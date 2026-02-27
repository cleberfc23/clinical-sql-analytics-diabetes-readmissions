import sqlite3
from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DB_PATH = PROJECT_ROOT / "clinical.db"
CSV_PATH = PROJECT_ROOT / "data" / "raw" / "diabetic_data.csv"


def connect(db_path: Path) -> sqlite3.Connection:
    connect_ = sqlite3.connect(db_path)
    # FOREING KEY only works when it is ON
    connect_.execute("PRAGMA foreing_keys = ON;")
    return connect_


def load_csv(csv_path: Path) -> pd.DataFrame:
    if not csv_path.exists():
        raise FileNotFoundError(f"CSV not found: {csv_path}")

    data_frame = pd.read_csv(csv_path)
    data_frame = data_frame.rename(
        columns={
            'A1Cresult': 'a1c_result',
            'diabetesMed': 'diabetes_med'
        }
    )

    return data_frame


def upsert_patients(conn: sqlite3.Connection, df: pd.DataFrame) -> int:
    patients = df[["patient_nbr", "race", "gender",
                   "age", "wight"]].drop_duplicates()
    sql = """
    INSERT OR REPLACE INTO patients (patients_nbr, race, gender, age, weight)
    VALUES (?, ?, ?, ?, ?); 
    """
    conn.executemany(sql, patients.intertuples(index=False, name=None))
    # only get the number of patients - no duplicate values (replace or insert)
    return len(patients)


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DB_PATH = PROJECT_ROOT / "clinical.db"
CSV_PATH = PROJECT_ROOT / "data" / "raw" / "diabetic_data.csv"


def connect(db_path: Path) -> sqlite3.Connection:
    conn = sqlite3.connect(db_path)
    # Enforce foreign keys in SQLite
    conn.execute("PRAGMA foreign_keys = ON;")
    return conn


def load_csv(csv_path: Path) -> pd.DataFrame:
    if not csv_path.exists():
        raise FileNotFoundError(f"CSV not found: {csv_path}")

    df = pd.read_csv(csv_path)

    # Minimal normalization: standardize column names we will use
    # Dataset uses "A1Cresult" -> we store in encounters.a1c_result
    # Dataset uses "diabetesMed" -> we store in encounters.diabetes_med
    df = df.rename(
        columns={
            "A1Cresult": "a1c_result",
            "diabetesMed": "diabetes_med",
        }
    )

    return df


def upsert_patients(conn: sqlite3.Connection, df: pd.DataFrame) -> int:
    patients = df[["patient_nbr", "race", "gender",
                   "age", "weight"]].drop_duplicates()

    sql = """
    INSERT OR REPLACE INTO patients (patient_nbr, race, gender, age, weight)
    VALUES (?, ?, ?, ?, ?);
    """
    conn.executemany(sql, patients.itertuples(index=False, name=None))
    return len(patients)


def insert_encounters(conn: sqlite3.Connection, df: pd.DataFrame) -> int:
    cols = [
        "encounter_id",
        "patient_nbr",
        "admission_type_id",
        "discharge_disposition_id",
        "admission_source_id",
        "time_in_hospital",
        "payer_code",
        "medical_specialty",
        "num_lab_procedures",
        "num_procedures",
        "num_medications",
        "number_outpatient",
        "number_emergency",
        "number_inpatient",
        "number_diagnoses",
        "max_glu_serum",
        "a1c_result",
        "insulin",
        "change",
        "diabetes_med",
        "readmitted",
    ]

    enc = df[cols].copy()

    numeric_cols = [
        "encounter_id",
        "patient_nbr",
        "admission_type_id",
        "discharge_disposition_id",
        "admission_source_id",
        "time_in_hospital",
        "num_lab_procedures",
        "num_procedures",
        "num_medications",
        "number_outpatient",
        "number_emergency",
        "number_inpatient",
        "number_diagnoses",
    ]
    for c in numeric_cols:
        enc[c] = pd.to_numeric(enc[c], errors="coerce")

    # Drop rows that would violate NOT NULL constraints
    enc = enc.dropna(subset=["encounter_id", "patient_nbr"])

    sql = f"""
    INSERT OR REPLACE INTO encounters (
      {", ".join(cols)}
    ) VALUES ({", ".join(["?"] * len(cols))});
    """
    conn.executemany(sql, enc.itertuples(index=False, name=None))
    return len(enc)


def insert_diagnoses(conn: sqlite3.Connection, df: pd.DataFrame) -> int:
    diag_cols = ["diag_1", "diag_2", "diag_3"]
    diag_df = df[["encounter_id"] + diag_cols].copy()
    diag_df["encounter_id"] = pd.to_numeric(diag_df["encounter_id"], errors="coerce")
    diag_df = diag_df.dropna(subset=["encounter_id"])

    long = diag_df.melt(
        id_vars=["encounter_id"],
        value_vars=diag_cols,
        var_name="diag_rank_col",
        value_name="diag_code",
    )

    rank_map = {"diag_1": 1, "diag_2": 2, "diag_3": 3}
    long["diag_rank"] = long["diag_rank_col"].map(rank_map)
    long = long.drop(columns=["diag_rank_col"])

    sql = """
    INSERT OR REPLACE INTO diagnoses (encounter_id, diag_rank, diag_code)
    VALUES (?, ?, ?);
    """
    conn.executemany(sql, long[["encounter_id", "diag_rank", "diag_code"]].itertuples(index=False, name=None))
    return len(long)



def main() -> None:
    if not DB_PATH.exists():
        raise FileNotFoundError(
            f"Database not found: {DB_PATH}. Did you create clinical.db and run database/schema.sql?"
        )

    df = load_csv(CSV_PATH)

    with connect(DB_PATH) as conn:
        n_patients = upsert_patients(conn, df)
        n_encounters = insert_encounters(conn, df)
        n_diagnoses = insert_diagnoses(conn, df)

        # Quick sanity checks
        patients_count = conn.execute("SELECT COUNT(*) FROM patients;").fetchone()[0]
        encounters_count = conn.execute("SELECT COUNT(*) FROM encounters;").fetchone()[0]
        diagnoses_count = conn.execute("SELECT COUNT(*) FROM diagnoses;").fetchone()[0]

    print(f"Inserted/updated patients:  {n_patients} (table count: {patients_count})")
    print(f"Inserted/updated encounters: {n_encounters} (table count: {encounters_count})")
    print(f"Inserted/updated diagnoses:  {n_diagnoses} (table count: {diagnoses_count})")


if __name__ == "__main__":
    main()


print("end-of-code OK!")
