use employees;

select emp_no, hire_date
FROM employees
ORDER BY hire_date ASC;

select emp_no, hire_date
FROM employees
ORDER BY hire_date ASC
limit 5; -- 출력 결과를 5개로 제한 하겠다.

select emp_no, hire_date
FROM employees
ORDER BY hire_date DESC
limit 5; -- 출력 결과를 5개로 제한 하겠다.

-- 어떤 기준으로 정렬해서 N개의 데이터 추출
-- Top - N 문제

SELECT emp_no, Hire_date
FROM employees
ORDER BY hire_date ASC
LIMIT 0, 5;
-- 시작(OFFSET) : 0  추출 개수 : 5