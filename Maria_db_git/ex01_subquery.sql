use sqldb;
-- SELECT 컬럼 목록 FROM 테이블명
-- * : 모든 컬럼

SELECT * FROM usertbl;

SELECT * FROM buytbl;


SELECT * -- SELECT 절 : 필드의 목록
FROM usertbl -- FROM 절 : 테이블 명
WHERE name='김경호'; -- WHERE 절 '=' 동등 연산자라 완전히 같을때 찾아준다.

SELECT userID, Name  -- 특정 컬럼을 출력하고 싶으면 속성을 넣어주면 된다
FROM usertbl
WHERE birthYear >= 1970 OR height >= 182;

SELECT userID, Name  -- 특정 컬럼을 출력하고 싶으면 속성을 넣어주면 된다
FROM usertbl
WHERE birthYear >= 1970 AND height >= 182;

SELECT userID, Name
FROM userTbl
WHERE height >= 180 AND height <= 183;

SELECT userID, Name
FROM userTbl
WHERE height BETWEEN 180 AND 183; --BETWEEN A AND B  (A <= height <= B)

-- BETWEEN 연산자
SELECT userID, addr
FROM userTbl
WHERE addr = '경남' OR addr = '전남' OR addr = '경북';


-- IN 연산자
SELECT userID, addr
FROM userTbl
WHERE addr IN('경남', '전남', '경북'); -- IN 은 OR 연산자 대신 쓰인다.

-- LIKE 연산자 -> 포함 연산자

-- <와일드 카드 문자>
-- % : 아무 글자가 와도 상관이 없다     EX) 김%
-- _ : 한개의 글자가 뭐가 와도 상관 없다    EX) _규

SELECT Name, height
FROM usertbl
WHERE name LIKE '김%';

SELECT Name, height
FROM usertbl
WHERE name LIKE '_종%'

-- Query (질의) 쿼리의 데이터 베이스를 전달한다.

select name, height -- 필드 목록 지정 
from usertbl -- 파일명
where height > 177; -- 필터 : 범위 설정


-- 김경호의 키보다 큰 사람 출력
-- 특정한 값이 아닌 '김경호의 키'
-- 이때 subQuety가 필요하다.ADD

SELECT name, height
FROM usertbl
where height > (select height from usertbl where name = '김경호');

SELECT name, height
FROM usertbl
where height > (select height from usertbl where add = '경남') ;
-- 2개 이상을 리턴하는 sub query를 사용할때 다른연산자를 사용해야 한다.
-- < ANY를 이용 >

SELECT height FROM usertbl where addr = '경남';
-- 170 , 173

SELECT Name, height FROM usertbl
WHERE height >= ANY (SELECT height FROM usertbl where addr = '경남');
-- 170이상 또는 173 이상 --> 170 이상

SELECT Name, height FROM usertbl
WHERE height >= All (SELECT height FROM usertbl where addr = '경남');
-- 170이상 그리고 173이상 --> 173 이상

SELECT name, height from usertbl
where height = SOME (SELECT height FROM usertbl WHERE addr='경남');
-- SOME 
-- ANY와 같은 의미
-- = 연산자와 사용 -> IN과 동일

SELECT name, height from usertbl
where height IN (SELECT height FROM usertbl WHERE addr='경남');
-- SELECT 옆에 있는 COLUMN도 한개의 값만 있어야 한다.

-- 오름차순 : ASC (디폴트 생략 가능)
-- 내림차순 : DESC

SELECT NAME, mDate 
FROM userTbl 
ORDER BY mDate DESC; -- DESC : 내림차순으로 정렬

SELECT NAME, height
FROM usertbl
ORDER BY height DESC, name ASC; 
-- 1차기준 : 키 내림 차순
-- (동률일때) 2차기준 : 이름 내림 차순
-- ASC는 생략 가능하다.

SELECT addr FROM usertbl;

SELECT DISTINCT addr 
FROM userTbl;
-- 주소 중복이 되어도 하나만 출력해라

use sqldb;

CREATE TABLE buyTbl2 (SELECT * FROM buyTbl);
-- 테이블을 복사하는 CREATE TABLE ... SELECT

SELECT * FROM buyTbl2;

SELECT userID, amount
FROM buytbl
ORDER BY userID;

SELECT userID, sum(amount*PRICE) AS total -- AS ~ : ~으로 이름을 바꾼다. (AS 생략 가능)
-- AMOUNT(갯수) * PRICE (가격) = 총 구매액  
FROM buytbl
GROUP BY userID
ORDER BY sum(amount) DESC ; 
-- 1) userID로 그룹핑해라
-- 2) 구매 수 총 합계를 구해라.
-- GROUP BY 쓸때 주의 할점 : GROUP BY에 제시한 CULUMN 과 집계 함수(SUM..)만 쓸수 있음

SELECT  COUNT(*) 
FROM usertbl;
-- 전체 행의 갯수
-- 페이지네이션 할 때 전체 데이터건 수 계산하는 방법

SELECT COUNT(mobile1) FROM usertbl;
-- 데이터가 없으면 카운트에 포함되지 않는다.

-- HAVING 절
-- GROUP BY 결과에서 필터링

SELECT userID '사용자' ,  sum(price*amount) '총구매액'
FROM buytbl
GROUP BY userID;

SELECT userID '사용자' ,  sum(price*amount) '총구매액'
FROM buytbl
WHERE price*amount > 100; 
-- WHERE 절은 Grouping 하기전에 처리된다.
--GROUP BY userID;

SELECT userID '사용자' ,  sum(price*amount) '총구매액'
FROM buytbl
GROUP BY userID
HAVING sum(price*amount) > 1000;
-- having절은 grouping 이후에 필터 처리



-- 테이블 생성 DDL
CREATE TABLE testTBL1(
    id int,             -- 사용자 id
    userName char(3),   -- 사용자 실제 이름 char(글자 갯수) <- 한글 영어 상관 없이 저장
    age int             -- 사용자 나이
);

-- INSERT
INSERT INTO testtbl1 -- 생략 됐으니 전체 컬럼
VALUES (1, '홍길동', 25); -- create 할때 제시한 순서 (id, name, age)

INSERT INTO testTBL1(id, userName) -- 컬럼 id, username 만 저장
VALUES (2, '설현');

INSERT INTO testtbl1 -- 생략 됐으니 전체 컬럼
VALUES (2, '둘리', 25);

-- 위치기반 매핑
INSERT INTO testTBL1(userName, age, id) 
VALUES ('초아', 26, 3);

SELECT * FROM testTBL1;

-- id는 행을 구분 해준 것이기 때문에
-- 중복 될 필요가 없다
-- 이때 중복 되지 않도록 사용 하는것이 <primary key> 이다

-- AUTO_INCREMENT : 자동으로 DBMS에게 1씩 추가 시키는 번호로 매겨라~ 이 기능을 맡기는 기능

CREATE TABLE testTBL2(
    id int AUTO_INCREMENT PRIMARY KEY,             -- 사용자 id
    userName char(3),   -- 사용자 실제 이름 char(글자 갯수) <- 한글 영어 상관 없이 저장
    age int             -- 사용자 나이
);

INSERT INTO testtbl2 VALUES (NULL, '지민', 25);
INSERT INTO testtbl2 VALUES (NULL, '유나', 22);
INSERT INTO testtbl2 VALUES (NULL, '유경', 21);

-- ALTER : 생성된 것을 변경할 때 사용한다.BIGINT
ALTER TABLE testtbl2 AUTO_INCREMENT = 100;
-- AUTO_INCREMENT = 100 시작 값을 100부터 시작 하겠다.

INSERT INTO testtbl2 VALUES(NULL, '찬미', 23);
SELECT *
FROM testtbl2;

INSERT INTO testtbl2 VALUES
(NULL, '나연', 20),
(NULL, '정연', 18),
(NULL, '모모', 19);

CREATE Table testTBL3 (
    id int, 
    Fname varchar(50), 
    Lname VARCHAR(50)
    );

-- < 테스트용 데이터 구축 >
INSERT INTO testTBL3 -- 컬럼 명이 생략 되어 있으므로 테이블 생성 때 지정한 이름으로 사용된다.
SELECT emp_no, first_name, last_name
FROM employees.employees; -- 다른 데이터 베이스를 사용할때 앞에 데이터 베이스 명을 써줘야한다.

SELECT *
FROM testtbl3;

-- UPDATE문
-- WHERE 절이 있으면 해당 조건이 참인 곳만 수정이 됨

SELECT *
FROM testtbl3
WHERE Fname = 'Kyoichi';

UPDATE testtbl3
set lname = '없음'
WHERE fname = 'Kyoichi';

UPDATE buytbl2
SET price = price * 1.5;


-- DELETE
-- WHERE 조건이 없으면 전체 행이 삭제

DELETE FROM testtbl3 WHERE Fname = 'Aamor';

DELETE FROM testtbl3 WHERE Fname = 'Mary' LIMIT 5;
