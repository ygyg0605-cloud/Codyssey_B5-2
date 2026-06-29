PRAGMA foreign_keys = ON;

-- 1. 전체 기관 목록을 조회한다.
SELECT *
FROM cell_type;

-- 2. 발현량이 90 이상인 발현 기록만 조회한다.
SELECT *
FROM expression_record
WHERE expression_level >= 90;

-- 3. 발현 기록을 발현량이 높은 순서대로 조회한다.
SELECT *
FROM expression_record
ORDER BY expression_level DESC;

-- 4. 최신 측정 기록 5개만 조회한다.
SELECT *
FROM expression_record
ORDER BY measured_at DESC
LIMIT 5;

-- 5. 세포와 해당 세포가 속한 기관 이름을 함께 조회한다. INNER JOIN 사용.
SELECT
    c.cell_name,
    o.organ_name,
    o.system_name
FROM cell_type c
INNER JOIN organ o
    ON c.organ_id = o.organ_id;

-- 6. 유전자와 해당 유전자가 주로 발현되는 세포 이름을 함께 조회한다. INNER JOIN 사용.
SELECT
    g.gene_symbol,
    g.gene_name,
    c.cell_name
FROM gene g
INNER JOIN cell_type c
    ON g.cell_type_id = c.cell_type_id;

-- 7. 단백질과 해당 단백질을 만드는 유전자 정보를 함께 조회한다. INNER JOIN 사용.
SELECT
    p.protein_name,
    g.gene_symbol,
    g.gene_name,
    p.function_text
FROM protein p
INNER JOIN gene g
    ON p.gene_id = g.gene_id;

-- 8. 모든 기관과 연결된 세포 정보를 조회한다. 세포가 없는 기관도 보이도록 LEFT JOIN 사용.
SELECT
    o.organ_name,
    c.cell_name
FROM organ o
LEFT JOIN cell_type c
    ON o.organ_id = c.organ_id;

-- 9. 기관별 발현 기록 개수를 조회한다. COUNT와 GROUP BY 사용.
SELECT
    o.organ_name,
    COUNT(e.expression_id) AS record_count
FROM organ o
INNER JOIN expression_record e
    ON o.organ_id = e.organ_id
GROUP BY o.organ_name;

-- 10. 세포별 평균 발현량을 조회한다. AVG와 GROUP BY 사용.
SELECT
    c.cell_name,
    AVG(e.expression_level) AS average_expression_level
FROM cell_type c
INNER JOIN expression_record e
    ON c.cell_type_id = e.cell_type_id
GROUP BY c.cell_name;

-- 11. 기관별 총 발현량을 조회한다. SUM과 GROUP BY 사용.
SELECT
    o.organ_name,
    SUM(e.expression_level) AS total_expression_level
FROM organ o
INNER JOIN expression_record e
    ON o.organ_id = e.organ_id
GROUP BY o.organ_name;