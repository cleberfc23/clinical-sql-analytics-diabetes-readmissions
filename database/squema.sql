PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS diagnoses;
DROP TABLE IF EXISTS encounters;
DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
  patient_nbr     INTEGER PRIMARY KEY,
  race            TEXT,
  gender          TEXT,
  age             TEXT,
  weight          TEXT,
  ingested_at     TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE encounters (
  encounter_id              INTEGER PRIMARY KEY,
  patient_nbr               INTEGER NOT NULL,

  admission_type_id         INTEGER,
  discharge_disposition_id  INTEGER,
  admission_source_id       INTEGER,

  time_in_hospital          INTEGER,
  payer_code                TEXT,
  medical_specialty         TEXT,

  num_lab_procedures        INTEGER,
  num_procedures            INTEGER,
  num_medications           INTEGER,
  number_outpatient         INTEGER,
  number_emergency          INTEGER,
  number_inpatient          INTEGER,
  number_diagnoses          INTEGER,

  max_glu_serum             TEXT,
  a1c_result                TEXT,

  insulin                   TEXT,
  change                    TEXT,
  diabetes_med              TEXT,
  readmitted                TEXT,

  ingested_at               TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (patient_nbr) REFERENCES patients(patient_nbr)
);

CREATE TABLE diagnoses (
  encounter_id  INTEGER NOT NULL,
  diag_rank     INTEGER NOT NULL CHECK (diag_rank IN (1,2,3)),
  diag_code     TEXT,

  ingested_at   TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (encounter_id, diag_rank),
  FOREIGN KEY (encounter_id) REFERENCES encounters(encounter_id)
);