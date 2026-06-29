# Codyssey_B5-2
- 과제설명
: 이 미션에서는 백엔드 프레임워크 없이, 도메인에 맞는 테이블 구조를 설계하고(PK/FK/제약조건) 직접 데이터를 넣고(INSERT) 필요한 정보를 뽑는(SELECT/JOIN/GROUP BY) 전체 흐름을 실습합니다. 단순 쿼리 연습이 아니라 "데이터 모델링 → 데이터 입력 → 요구사항을 SQL로 해결"하는 과정을 결과물로 남깁니다.
또한, 이후 JPA/ORM을 학습할 때 필요한 관계(1:N), 키(PK/FK), 무결성, 조인 기반 조회 사고방식을 먼저 체득하게 됩니다. 즉, ORM이 해주는 일을 "SQL 관점에서" 이해할 수 있는 기반을 만드는 미션입니다.

## 과제 directory 구조
```
bio_expression_db
  01_schema.sql
  02_insert_data.sql
  03_queries.sql
  results
```
01_schema.sql:
DB 구조를 만드는 파일.
즉, 테이블을 만드는 코드가 들어감.

```
PRAGMA foreign_keys = ON; # SQLite에서 FK 규칙을 사용할 때 키면 좋은 설정
```

02_insert_data.sql:
샘플 데이터를 넣는 파일.
즉, 기관, 세포, 유전자, 단백질 정보를 실제로 입력하는 코드가 들어감.

03_queries.sql
과제에서 요구한 15개 쿼리가 들어감.

results
쿼리 실행 결과를 텍스트나 캡처로 저장하는 폴더.

## DB를 SQLite로 한 이유
1. 서버 설치가 거의 필요 없음
2. 파일 하나가 DB가 됨
3. VSCode 확장 프로그램으로 바로 실행 가능함

## Database table 구조

```
organ #Liver, Brain, Heart, Lung
cell_type #Hepatocyte, Neuron, Cardiomyocyte, Alveolar cell
gene #ALB, INS, MB, GFAP
protein #Albumin, Insulin, Myoglobin, GFAP protein
expression_record #organ, cell_type, gene, protein을 함께 연결함.
```

## table 만들기

### Organ table
```
CREATE TABLE organ (         # Organ이라는 테이블을 만든다
    organ_id INTEGER PRIMARY KEY,    # organ_id라는 열을 만들고 PRIMARY KEY는 정수로 한다.
    organ_name TEXT NOT NULL UNIQUE,    # organ_name은 글자 데이터로 하고 비우거나 중복되면 안된다.
    system_name TEXT NOT NULL    #기관계 이름은 비우면 안된다
);
```

### Cell_type table
```
CREATE TABLE cell_type (
    cell_type_id INTEGER PRIMARY KEY,
    cell_name TEXT NOT NULL UNIQUE,
    organ_id INTEGER NOT NULL,
    description TEXT,
    FOREIGN KEY (organ_id) REFERENCES organ(organ_id)   # 이 테이블의 organ_id는 반드시 organ 테이블에 있는 organ_id 값이어야 한다.
);
```

## DB 실행
SQLite로 01 파일을 실행시킨다.

<img width="471" height="531" alt="image" src="https://github.com/user-attachments/assets/2eb158af-e9d2-4c83-8436-3acc7a9049b6" />

bio_expression.db에 테이블 생성 확인

<img width="390" height="228" alt="image" src="https://github.com/user-attachments/assets/a2b25ddd-1e69-453a-91cc-92d035697b37" />

SQLite로 02 파일을 실행시킨다.

<img width="712" height="639" alt="image" src="https://github.com/user-attachments/assets/50db2b4e-5f63-4f7c-baf1-d494b44c0e08" />


03파일에 SQL 명령어로 실행 확인

<img width="977" height="432" alt="image" src="https://github.com/user-attachments/assets/4670a339-1d1a-42b3-b886-32c544c0be91" />


## SQL 쿼리 파트
: 1~4번은 기본 조회, 5~8번은 Join, 9~11번은 집계, 12번은 서브쿼리, 13~14번은 수정/삭제, 15번은 인덱스로 구성

```
기본 조회

1. SELECT
2. WHERE
3. ORDER BY
4. LIMIT
```

- 1번 실행

<img width="730" height="381" alt="image" src="https://github.com/user-attachments/assets/f6142571-9e7f-4e9c-a5c5-edc02ded906e" />

- 2번 실행

<img width="605" height="225" alt="image" src="https://github.com/user-attachments/assets/5580d15a-f962-433b-9a1b-3915e03d34fd" />

- 3번 실행

<img width="609" height="436" alt="image" src="https://github.com/user-attachments/assets/440e6ea8-ad5a-4b4e-aa03-ead5ce065912" />

- 4번 실행

<img width="617" height="222" alt="image" src="https://github.com/user-attachments/assets/adbfb432-fddf-43f4-a5eb-92562e224336" />

```
Join - 숫자 ID로 연결된 테이블을 합쳐서 사람이 읽기 쉬운 결과로 보여주는 것

5. 세포와 해당 세포가 속한 기관 이름을 함께 조회한다. INNER JOIN 사용.
6. 유전자와 해당 유전자가 주로 발현되는 세포 이름을 함께 조회한다. INNER JOIN 사용.
7. 단백질과 해당 단백질을 만드는 유전자 정보를 함께 조회한다. INNER JOIN 사용.
8. 모든 기관과 연결된 세포 정보를 조회한다. 세포가 없는 기관도 보이도록 LEFT JOIN 사용.
```

- 5번 실행

<img width="551" height="375" alt="image" src="https://github.com/user-attachments/assets/725c5b71-d738-49eb-82a5-a9bd3c5f55dd" />

- 6번 실행

<img width="624" height="374" alt="image" src="https://github.com/user-attachments/assets/19a2ae43-b306-4b4d-a509-aed708b7810a" />

- 7번 실행

<img width="1147" height="377" alt="image" src="https://github.com/user-attachments/assets/2628b534-5f0b-4626-8e0d-09d30c83e29e" />

- 8번 실행

<img width="458" height="373" alt="image" src="https://github.com/user-attachments/assets/4acfcabe-7ace-471e-877c-cd541bff6a79" />

```
집계 - 여러 데이터를 모아서 계산

9. 기관별 발현 기록 개수를 조회한다. COUNT와 GROUP BY 사용.
10. 세포별 평균 발현량을 조회한다. AVG와 GROUP BY 사용.
11. 기관별 총 발현량을 조회한다. SUM과 GROUP BY 사용.
```

- 9번 실행

<img width="383" height="379" alt="image" src="https://github.com/user-attachments/assets/5c8264bb-d0bd-489a-9e90-b91075d48f9e" />


- 10번 실행

<img width="505" height="373" alt="image" src="https://github.com/user-attachments/assets/d26a9420-cb0f-4aee-88ee-5b2d1c034bc2" />


- 11번 실행

<img width="495" height="381" alt="image" src="https://github.com/user-attachments/assets/67d07a01-1e51-416e-9032-dbae8bcff4ba" />

```
서브쿼리 - SQL 안에 들어있는 또 다른 SQL이다. 쉽게 말하면 쿼리 안에 들어간 작은 쿼리

12. 전체 평균 발현량보다 높은 발현 기록만 조회한다. 서브쿼리 사용.
```

- 12번 실행

<img width="615" height="230" alt="image" src="https://github.com/user-attachments/assets/3bb7edb7-5659-4c8d-8cd7-40585214c167" />

```
수정
삭제

13. 특정 발현 기록의 발현량을 수정. UPDATE 사용. 수정 후 결과까지 확인
14. 특정 단백질 데이터를 삭제. DELETE 사용. 삭제 후 결과까지 확인
```

- 13번 실행

<img width="613" height="122" alt="image" src="https://github.com/user-attachments/assets/ab06b3d9-c7ce-4611-b862-2bb3a875fcf0" />

-14번 실행

<img width="532" height="315" alt="image" src="https://github.com/user-attachments/assets/6742772d-7a9c-45ee-bb87-a88431f3f8c4" />


```
Index - DB에서 검색을 빠르게 하기 위한 장치

15. 발현 기록의 측정 날짜 검색 속도를 높이기 위해 인덱스를 만든다.
-- measured_at 컬럼은 날짜 조건 검색과 최신순 정렬에 자주 사용될 수 있으므로 인덱스를 적용한다.
```

-15번 실행

<img width="658" height="248" alt="image" src="https://github.com/user-attachments/assets/d088dfb1-7cbe-4609-a03b-d0d189df2859" />


# Bio Expression Database 과제 보완 정리

## 1. 테이블 구성과 역할

이 데이터베이스는 세포, 유전자, 단백질, 기관, 발현 기록을 관리하기 위한 데이터베이스이다.

총 5개의 테이블을 사용했다.

| 테이블명 | 역할 |
|---|---|
| organ | 기관 정보를 저장한다. 예: Liver, Brain, Heart |
| cell_type | 세포 종류 정보를 저장한다. 예: Hepatocyte, Neuron |
| gene | 유전자 정보를 저장한다. 예: ALB, INS |
| protein | 유전자가 만드는 단백질 정보를 저장한다. |
| expression_record | 어떤 유전자가 어떤 세포와 기관에서 얼마나 발현되었는지 기록한다. |

각 테이블은 PK를 가진다.

| 테이블명 | PK |
|---|---|
| organ | organ_id |
| cell_type | cell_type_id |
| gene | gene_id |
| protein | protein_id |
| expression_record | expression_id |

PK는 각 테이블에서 한 행을 구분하는 고유 번호이다.

---

## 2. FK를 사용한 1:N 관계

이 데이터베이스에는 FK를 사용한 1:N 관계가 여러 개 존재한다.

### 2-1. organ : cell_type = 1 : N

```sql
FOREIGN KEY (organ_id) REFERENCES organ(organ_id)
```

`cell_type.organ_id`는 `organ.organ_id`를 참조한다.

의미:

- 하나의 기관은 여러 세포 유형을 가질 수 있다.
- 예를 들어 `Liver`라는 기관에는 `Hepatocyte` 같은 세포가 연결될 수 있다.

### 2-2. cell_type : gene = 1 : N

```sql
FOREIGN KEY (cell_type_id) REFERENCES cell_type(cell_type_id)
```

`gene.cell_type_id`는 `cell_type.cell_type_id`를 참조한다.

의미:

- 하나의 세포 유형은 여러 유전자와 연결될 수 있다.
- 예를 들어 `Hepatocyte` 세포에는 `ALB` 유전자가 연결될 수 있다.

### 2-3. gene : protein = 1 : N

```sql
FOREIGN KEY (gene_id) REFERENCES gene(gene_id)
```

`protein.gene_id`는 `gene.gene_id`를 참조한다.

의미:

- 하나의 유전자는 여러 단백질 정보와 연결될 수 있다.

### 2-4. expression_record의 FK

```sql
FOREIGN KEY (gene_id) REFERENCES gene(gene_id),
FOREIGN KEY (cell_type_id) REFERENCES cell_type(cell_type_id),
FOREIGN KEY (organ_id) REFERENCES organ(organ_id)
```

`expression_record`는 `gene`, `cell_type`, `organ`을 각각 참조한다.

의미:

- 하나의 발현 기록은 특정 유전자, 특정 세포, 특정 기관과 연결된다.

---

## 3. FK 참조 무결성 확인

없는 값을 참조하면 FK 제약조건 때문에 INSERT가 실패한다.

확인용 SQL:

```sql
PRAGMA foreign_keys = ON;

INSERT INTO cell_type (cell_type_id, cell_name, organ_id, description)
VALUES (99, 'Invalid Cell', 999, 'This should fail');
```

예상 결과:

```text
FOREIGN KEY constraint failed
```

설명:

`organ` 테이블에는 `organ_id = 999`인 기관이 없다.  
따라서 `cell_type` 테이블에서 존재하지 않는 기관을 참조하려고 하면 DB가 입력을 막는다.  
이것이 FK를 통한 참조 무결성이다.

---

## 4. 각 테이블 10행 이상 데이터 확인

각 테이블에 최소 10행 이상 데이터가 있는지 확인하기 위해 다음 쿼리를 사용했다.

```sql
SELECT 'organ' AS table_name, COUNT(*) AS row_count FROM organ
UNION ALL
SELECT 'cell_type', COUNT(*) FROM cell_type
UNION ALL
SELECT 'gene', COUNT(*) FROM gene
UNION ALL
SELECT 'protein', COUNT(*) FROM protein
UNION ALL
SELECT 'expression_record', COUNT(*) FROM expression_record;
```

확인 기준:

```text
모든 테이블의 row_count가 10 이상이면 조건을 만족한다.
```

---

## 5. 테이블을 나눈 이유

처음에는 엑셀처럼 하나의 표에 모든 데이터를 저장할 수도 있다.

예시:

| organ | cell_type | gene | protein | expression_level |
|---|---|---|---|---|
| Liver | Hepatocyte | ALB | Albumin protein | 95.5 |
| Liver | Hepatocyte | ALB | Albumin protein | 93.2 |

하지만 이렇게 하면 같은 값이 반복된다.

문제점:

- `Liver` 같은 기관 이름이 여러 번 반복된다.
- `Hepatocyte` 같은 세포 이름도 여러 번 반복된다.
- 같은 데이터를 수정할 때 여러 행을 모두 고쳐야 한다.
- 오타가 생기면 같은 기관이나 세포가 다른 값처럼 저장될 수 있다.

그래서 데이터를 역할별로 나누었다.

| 데이터 종류 | 저장 테이블 |
|---|---|
| 기관 정보 | organ |
| 세포 정보 | cell_type |
| 유전자 정보 | gene |
| 단백질 정보 | protein |
| 발현 기록 | expression_record |

이렇게 나누면 중복을 줄이고, FK를 통해 관계를 안전하게 연결할 수 있다.

---

## 6. 데이터베이스와 엑셀의 차이

엑셀은 표 형태로 데이터를 정리하기 쉽다.  
하지만 테이블 사이의 관계를 강하게 관리하기 어렵다.

데이터베이스는 PK와 FK를 통해 테이블 사이의 관계를 표현할 수 있다.

예시:

```text
cell_type.organ_id -> organ.organ_id
gene.cell_type_id -> cell_type.cell_type_id
protein.gene_id -> gene.gene_id
```

또한 데이터베이스는 제약조건을 사용할 수 있다.

| 제약조건 | 의미 |
|---|---|
| PRIMARY KEY | 각 행을 구분하는 고유 값 |
| FOREIGN KEY | 다른 테이블의 PK를 참조하는 값 |
| NOT NULL | 반드시 값이 있어야 함 |
| UNIQUE | 중복되면 안 됨 |

정리하면 엑셀은 단순한 표 관리에 가깝고, 데이터베이스는 관계와 규칙을 가진 데이터 저장소이다.

---

## 7. 컬럼 타입 선택 이유

각 컬럼은 저장할 데이터의 성격에 맞게 타입을 선택했다.

| 타입 | 사용 위치 | 선택 이유 |
|---|---|---|
| INTEGER | organ_id, cell_type_id, gene_id 등 | 각 행을 구분하는 숫자 ID를 저장하기 위해 사용 |
| TEXT | organ_name, cell_name, gene_symbol 등 | 이름, 기호, 설명 같은 문자 데이터를 저장하기 위해 사용 |
| REAL | expression_level | 95.5처럼 소수점이 있는 발현량을 저장하기 위해 사용 |
| TEXT | measured_at | SQLite에서는 날짜를 문자열 형태로 저장할 수 있기 때문에 사용 |

예시:

```sql
expression_level REAL NOT NULL
```

설명:

발현량은 `95.5`, `88.2`처럼 소수점이 있을 수 있으므로 `REAL`을 사용했다.

예시:

```sql
measured_at TEXT NOT NULL
```

설명:

SQLite에서는 날짜를 `2026-06-01` 같은 문자열로 저장할 수 있다.  
이 형식은 날짜순 정렬에도 사용할 수 있다.

---

## 8. INNER JOIN과 LEFT JOIN 차이

### INNER JOIN

```sql
SELECT
    c.cell_name,
    o.organ_name
FROM cell_type c
INNER JOIN organ o
    ON c.organ_id = o.organ_id;
```

의미:

`cell_type` 테이블과 `organ` 테이블에서 `organ_id`가 같은 데이터만 연결해서 보여준다.

특징:

- 양쪽 테이블에 연결되는 데이터가 있을 때만 결과에 나온다.
- 연결되지 않은 데이터는 결과에서 제외된다.

### LEFT JOIN

```sql
SELECT
    o.organ_name,
    c.cell_name
FROM organ o
LEFT JOIN cell_type c
    ON o.organ_id = c.organ_id;
```

의미:

`organ` 테이블을 기준으로 모든 기관을 보여주고, 연결된 세포가 있으면 함께 보여준다.

특징:

- 왼쪽 테이블인 `organ`의 데이터는 모두 나온다.
- 연결된 `cell_type`이 없으면 세포 값은 비어 있을 수 있다.

정리:

| JOIN 종류 | 결과 |
|---|---|
| INNER JOIN | 양쪽 테이블에서 조건이 맞는 데이터만 조회 |
| LEFT JOIN | 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 연결되면 함께 조회 |

---

## 9. GROUP BY와 집계 함수

`GROUP BY`는 같은 값끼리 데이터를 묶을 때 사용한다.

예시:

```sql
SELECT
    c.cell_name,
    AVG(e.expression_level) AS average_expression_level
FROM cell_type c
INNER JOIN expression_record e
    ON c.cell_type_id = e.cell_type_id
GROUP BY c.cell_name;
```

동작 방식:

1. `cell_type`과 `expression_record`를 `cell_type_id` 기준으로 연결한다.
2. `c.cell_name`이 같은 데이터끼리 묶는다.
3. 각 세포별로 `expression_level`의 평균을 계산한다.

집계 함수:

| 함수 | 의미 |
|---|---|
| COUNT | 개수를 센다 |
| SUM | 합계를 구한다 |
| AVG | 평균을 구한다 |

예시:

```sql
COUNT(e.expression_id)
```

발현 기록의 개수를 센다.

```sql
SUM(e.expression_level)
```

발현량의 총합을 구한다.

```sql
AVG(e.expression_level)
```

발현량의 평균을 구한다.

---

## 10. 가장 복잡했던 쿼리 설명

가장 복잡했던 쿼리는 전체 평균 발현량보다 높은 발현 기록을 찾는 서브쿼리이다.

```sql
SELECT *
FROM expression_record
WHERE expression_level > (
    SELECT AVG(expression_level)
    FROM expression_record
);
```

단계별 설명:

1. 괄호 안의 쿼리가 먼저 실행된다.

```sql
SELECT AVG(expression_level)
FROM expression_record;
```

2. 이 쿼리는 전체 발현량의 평균값을 구한다.

3. 바깥 쿼리는 그 평균값보다 큰 발현 기록만 조회한다.

```sql
SELECT *
FROM expression_record
WHERE expression_level > 평균값;
```

정리:

이 쿼리는 고정된 숫자를 조건으로 사용하는 것이 아니라, DB 안의 데이터를 이용해 평균을 계산하고 그 값을 다시 조건으로 사용하는 쿼리이다.

---

## 11. 인덱스 적용 이유

인덱스는 데이터를 더 빠르게 찾기 위한 장치이다.

사용한 인덱스:

```sql
CREATE INDEX idx_expression_record_measured_at
ON expression_record(measured_at);
```

적용 이유:

`measured_at` 컬럼은 측정 날짜를 저장한다.  
최신 측정 기록을 조회하거나 날짜 조건으로 검색할 때 자주 사용될 수 있다.

예시:

```sql
SELECT *
FROM expression_record
ORDER BY measured_at DESC
LIMIT 5;
```

이런 쿼리에서 `measured_at` 기준 정렬이나 검색이 자주 발생할 수 있으므로 인덱스를 적용했다.

---

## 12. 제출물 구성

최종 제출물은 다음과 같이 구성했다.

```text
bio_expression_db/
  01_schema.sql
  02_insert_data.sql
  03_queries.sql
  bio_expression.db
  results/
    query_01.png
    query_02.png
    ...
    query_15.png
```

각 파일의 역할:

| 파일/폴더 | 역할 |
|---|---|
| 01_schema.sql | 테이블 생성, PK/FK/제약조건 정의 |
| 02_insert_data.sql | 샘플 데이터 INSERT |
| 03_queries.sql | 기본 조회, JOIN, 집계, 서브쿼리, UPDATE, DELETE, INDEX 쿼리 작성 |
| results | 각 쿼리 실행 결과 캡처 저장 |
| bio_expression.db | SQLite 데이터베이스 파일 |








