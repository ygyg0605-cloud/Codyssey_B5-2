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











