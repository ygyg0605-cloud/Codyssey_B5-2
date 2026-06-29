PRAGMA foreign_keys = ON;

INSERT INTO organ (organ_id, organ_name, system_name) VALUES
(1, 'Liver', 'Digestive system'),
(2, 'Brain', 'Nervous system'),
(3, 'Heart', 'Circulatory system'),
(4, 'Lung', 'Respiratory system'),
(5, 'Pancreas', 'Endocrine system'),
(6, 'Kidney', 'Urinary system'),
(7, 'Stomach', 'Digestive system'),
(8, 'Small intestine', 'Digestive system'),
(9, 'Skin', 'Integumentary system'),
(10, 'Bone marrow', 'Hematopoietic system');

INSERT INTO cell_type (cell_type_id, cell_name, organ_id, description) VALUES
(1, 'Hepatocyte', 1, 'Main functional cell of the liver'),
(2, 'Neuron', 2, 'Signal-transmitting cell of the nervous system'),
(3, 'Cardiomyocyte', 3, 'Muscle cell responsible for heart contraction'),
(4, 'Alveolar type II cell', 4, 'Lung cell involved in surfactant production'),
(5, 'Pancreatic beta cell', 5, 'Cell that produces insulin'),
(6, 'Podocyte', 6, 'Kidney cell involved in blood filtration'),
(7, 'Parietal cell', 7, 'Stomach cell that secretes acid'),
(8, 'Enterocyte', 8, 'Absorptive cell of the small intestine'),
(9, 'Keratinocyte', 9, 'Major cell type of the skin epidermis'),
(10, 'Hematopoietic stem cell', 10, 'Stem cell that produces blood cells');

INSERT INTO gene (gene_id, gene_symbol, gene_name, cell_type_id) VALUES
(1, 'ALB', 'Albumin', 1),
(2, 'MAP2', 'Microtubule Associated Protein 2', 2),
(3, 'MYH7', 'Myosin Heavy Chain 7', 3),
(4, 'SFTPC', 'Surfactant Protein C', 4),
(5, 'INS', 'Insulin', 5),
(6, 'NPHS1', 'Nephrin', 6),
(7, 'ATP4A', 'ATPase H+/K+ Transporting Subunit Alpha', 7),
(8, 'ALPI', 'Alkaline Phosphatase, Intestinal', 8),
(9, 'KRT14', 'Keratin 14', 9),
(10, 'CD34', 'CD34 Molecule', 10);

INSERT INTO protein (protein_id, protein_name, gene_id, function_text) VALUES
(1, 'Albumin protein', 1, 'Maintains blood osmotic pressure and transports molecules'),
(2, 'MAP2 protein', 2, 'Supports neuron structure and microtubule stability'),
(3, 'Myosin heavy chain beta', 3, 'Supports contraction in cardiac muscle cells'),
(4, 'Surfactant protein C', 4, 'Helps reduce surface tension in the lung'),
(5, 'Insulin protein', 5, 'Regulates blood glucose level'),
(6, 'Nephrin protein', 6, 'Supports the kidney filtration barrier'),
(7, 'Gastric proton pump alpha subunit', 7, 'Supports acid secretion in the stomach'),
(8, 'Intestinal alkaline phosphatase', 8, 'Supports intestinal absorption and barrier function'),
(9, 'Keratin 14 protein', 9, 'Provides structural support in skin cells'),
(10, 'CD34 protein', 10, 'Marker protein for hematopoietic stem and progenitor cells');

INSERT INTO expression_record (
    expression_id,
    gene_id,
    cell_type_id,
    organ_id,
    expression_level,
    measured_at
) VALUES
(1, 1, 1, 1, 95.5, '2026-06-01'),
(2, 2, 2, 2, 88.2, '2026-06-02'),
(3, 3, 3, 3, 91.7, '2026-06-03'),
(4, 4, 4, 4, 76.4, '2026-06-04'),
(5, 5, 5, 5, 98.1, '2026-06-05'),
(6, 6, 6, 6, 72.8, '2026-06-06'),
(7, 7, 7, 7, 84.6, '2026-06-07'),
(8, 8, 8, 8, 69.3, '2026-06-08'),
(9, 9, 9, 9, 80.9, '2026-06-09'),
(10, 10, 10, 10, 73.5, '2026-06-10'),
(11, 1, 1, 1, 93.2, '2026-06-11'),
(12, 5, 5, 5, 96.7, '2026-06-12');