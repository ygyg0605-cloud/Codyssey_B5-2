PRAGMA foreign_keys = ON;

CREATE TABLE organ (
    organ_id INTEGER PRIMARY KEY,
    organ_name TEXT NOT NULL UNIQUE,
    system_name TEXT NOT NULL
);

CREATE TABLE cell_type (
    cell_type_id INTEGER PRIMARY KEY,
    cell_name TEXT NOT NULL UNIQUE,
    organ_id INTEGER NOT NULL,
    description TEXT,
    FOREIGN KEY (organ_id) REFERENCES organ(organ_id)
);

CREATE TABLE gene (
    gene_id INTEGER PRIMARY KEY,
    gene_symbol TEXT NOT NULL UNIQUE,
    gene_name TEXT NOT NULL,
    cell_type_id INTEGER NOT NULL,
    FOREIGN KEY (cell_type_id) REFERENCES cell_type(cell_type_id)
);

CREATE TABLE protein (
    protein_id INTEGER PRIMARY KEY,
    protein_name TEXT NOT NULL,
    gene_id INTEGER NOT NULL,
    function_text TEXT,
    FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
);

CREATE TABLE expression_record (
    expression_id INTEGER PRIMARY KEY,
    gene_id INTEGER NOT NULL,
    cell_type_id INTEGER NOT NULL,
    organ_id INTEGER NOT NULL,
    expression_level REAL NOT NULL,
    measured_at TEXT NOT NULL,
    FOREIGN KEY (gene_id) REFERENCES gene(gene_id),
    FOREIGN KEY (cell_type_id) REFERENCES cell_type(cell_type_id),
    FOREIGN KEY (organ_id) REFERENCES organ(organ_id)
);