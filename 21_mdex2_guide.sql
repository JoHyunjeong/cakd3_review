-- 08�� 11�� --


-- �ܼ� ����� �� FROM dual ���
-- ���밪
SELECT ABS(-78), ABS(+78)
FROM dual;

-- �ݿø�
SELECT ROUND(4.875, 1)
FROM dual;

-- Q. ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.
SELECT * FROM orders;

SELECT custid, ROUND(SUM(saleprice)/count(*),-2) "��ձݾ�"
FROM orders
GROUP BY custid;

-- Q. ���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� ���� ���, ������ ���̽ÿ�.
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM book;

SELECT * FROM book;

-- Q. '�½�����'���� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.
-- ���ڼ� LENGTH, ����Ʈ�� LENGTHB
SELECT bookname ����, LENGTH(bookname) "������ ���� ��", LENGTHB(bookname) "����Ʈ ��"
FROM book
WHERE publisher = '�½�����';

-- Q. ���缭���� �� �߿��� ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
SELECT * FROM customer;

SELECT SUBSTR(name, 1, 1) ��, COUNT(*) �ο�
FROM customer
GROUP BY SUBSTR(name, 1, 1);

-- Q. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
SELECT * FROM orders;
SELECT orderid, custid, orderdate, orderdate+10 Ȯ������
FROM orders;

-- �Ƹ�bb
SELECT o.*, o.orderdate + 10 Ȯ������ 
FROM orders o;

-- Q. ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�.
-- �� �ֹ����� 'yyyy-mm-dd ����' ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate,'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = '2020-07-07';

-- Q. DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.
SELECT SYSDATE
FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd day HH24:mi:ss') SYSDATE1
FROM dual;

-- mm�� month�� �νĵ� �� �ִ� �� ����(???)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD day HH:mi:ss') SYSDATE1
FROM dual;


-- Q. �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� '����ó ����'���� ǥ���Ͻÿ�.
-- NVL(�Ӽ�,��) -> '�Ӽ�'���� '��'���� Null �� ��ü
SELECT name �̸�, NVL(phone, '����ó ����') ��ȭ��ȣ
FROM customer;

-- �ر�?
SELECT name �̸�, COALESCE(phone, '����ó ����') ��ȭ��ȣ
FROM customer;

-- ���ƴ� - Null�� ��ȯ
SELECT custid,name, phone
FROM customer
WHERE TRIM(phone) IS NULL;

-- Q. ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.
-- ROWNUM ���
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <=2;

-- Q. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT *
FROM orders;

SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

-- Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ������� ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o2.custid=o1.custid);

-- ������ --
SELECT o1.orderid �ֹ���ȣ, o1.custid ����ȣ, o1.saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) 
                      FROM orders o2
                      WHERE o1.custid = o2.custid
                      GROUP BY o2.custid);

-- Q. '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice)
FROM customer C, orders O
WHERE C.custid = O.custid AND address LIKE '%���ѹα�%';

--������ --
SELECT SUM(saleprice)
FROM orders O
WHERE O.custid IN(SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');

-- Q. 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, saleprice �ݾ�
FROM orders
WHERE saleprice > (SELECT MAX(saleprice)
FROM orders
WHERE custid = 3
GROUP BY custid);

-- ������--
SELECT orderid, saleprice
FROM orders
WHERE saleprice > ALL(SELECT saleprice FROM orders WHERE custid='3');

-- Q. EXISTS �����ڸ� ����Ͽ� '���ѹα�'�� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT SUM(saleprice) total
FROM orders O
WHERE EXISTS (SELECT * FROM customer C WHERE address LIKE '���ѹα�%' AND O.custid = C.custid);


-- Q. ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
SELECT name, SUM(saleprice)
FROM orders, customer
WHERE orders.custid = customer.custid
GROUP BY name;

--������--
SELECT (SELECT name FROM customer C WHERE C.custid=O.custid) name, SUM(saleprice) total 
FROM orders O
GROUP BY O.custid;

-- �ٸ���(NULL �� ó������!)
SELECT C.name ���̸�, NVL(SUM(O.saleprice),0) "���� �Ǹž�"
FROM customer C, orders O
WHERE C.custid = O.custid(+)
GROUP BY C.name;


---------------------------------------------------------------
-- ���ο� �÷� ���� �ٸ� ���̺� �ִ� �� ä���ֱ�
SELECT * FROM orders;
ALTER TABLE orders ADD bookname VARCHAR2(40);

UPDATE orders
SET bookname = (SELECT bookname FROM book WHERE book.bookid = orders.bookid);


-- VIEW �����
CREATE VIEW vw_Customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT *
FROM vw_Customer;

-- Q. Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, '�迬��' ���� ������ ������
-- �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.
CREATE VIEW vw_�迬��
AS SELECT orders.orderid �ֹ���ȣ, book.bookname �����̸�, orders.saleprice �ֹ���
FROM orders, book, customer
WHERE orders.bookid = book.bookid AND orders.custid = customer.custid AND customer.name='�迬��';

SELECT * FROM vw_�迬��;

CREATE VIEW vw_�迬��1
AS SELECT orders.orderid �ֹ���ȣ, orders.bookname �����̸�, orders.saleprice �ֹ���
FROM orders, customer
WHERE orders.custid = customer.custid AND customer.name='�迬��';

SELECT * FROM vw_�迬��1;







-- [����_0811] --

-- Q. �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ������� ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) FROM orders o2 WHERE o2.custid=o1.custid);

-- ������ --
SELECT o1.orderid �ֹ���ȣ, o1.custid ����ȣ, o1.saleprice �ݾ�
FROM orders o1
WHERE o1.saleprice > (SELECT AVG(o2.saleprice) 
                      FROM orders o2
                      WHERE o1.custid = o2.custid
                      GROUP BY o2.custid);
                      
SELECT orderid �ֹ���ȣ, custid ����ȣ, saleprice �ݾ�
FROM orders O1
WHERE O1.saleprice > (SELECT AVG(O2.saleprice) FROM orders O2 GROUP BY O1.custid);


-- Q. ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���)
SELECT name ���̸�, SUM(saleprice) "���� �Ǹž�"
FROM orders O, customer C
WHERE O.custid = C.custid AND C.custid <=2
GROUP BY C.name;

-- Q. �ּҿ� '���ѹα�'�� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.
CREATE VIEW vw_Customer
AS SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT *
FROM vw_Customer;

-- Q. �ռ� ������ �� vw_Customer�� �����Ͻÿ�.
DROP VIEW vw_Customer;


-- 08�� 12�� --

-- ���ڿ� ���� -- 
SELECT * FROM employees;

SELECT last_name,'is a', job_id FROM employees;

SELECT last_name || ' is a ' || job_id FROM employees;

SELECT last_name || ' ' || first_name FROM employees;


-- DISTINCT -- 
SELECT job_id FROM employees;

SELECT DISTINCT job_id FROM employees;


-- NULL �� Ȯ�� --
SELECT * FROM employees WHERE commission_pct is null;
-- NULL �ƴ� �� Ȯ��
SELECT * FROM employees WHERE commission_pct is not null;

-- Q. EMPLYEES ���̺��� commission_pct�� Null�� ������ ����ϼ���.
SELECT count(*)
FROM employees
WHERE commission_pct is null;



-- ���� �Լ� Number Function --


-- MOD : ������ -- 
SELECT MOD(10,3) FROM dual;

-- Q. EMPOYEES ���̺��� employee_id�� Ȧ���� �͸� ����ϼ���.
SELECT *
FROM employees
WHERE MOD(employee_id,2)=1;


-- ROUND(���� �ø�) --
SELECT ROUND(355.95555) FROM dual;
SELECT ROUND(355.95555,0) FROM dual;

SELECT ROUND(355.95555,2) FROM dual;

SELECT ROUND(355.95555,-1) FROM dual;


-- TRUNC(���� ����) --
SELECT ROUND(45.5555,1) FROM dual;
SELECT TRUNC(45.5555,1) FROM dual;


SELECT * FROM employees;


-- Q. salary�� �������� �Ҽ��� ��° �ڸ����� �����Ͽ� ���Ͻÿ�. --
SELECT last_name, TRUNC(salary/12,2) ���� FROM employees;


-- WIDTH_BUCKET : ���������� --
-- WIDTH_BUCKET(������, �ּҰ�, �ִ밪, BUCKET����) -- 
SELECT WIDTH_BUCKET(92, 0, 100, 10) FROM dual;



-- ���� �Լ� -- 
-- UPPER, LOWER -> ��ȸ�� ���� ����. ������ �ٲ��� ����!
-- UPPER : ��� �빮�ڷ� �ٲٱ� --
SELECT UPPER('Hello World') FROM dual;


-- LOWER : ��� �ҹ��ڷ� �ٲٱ� --
SELECT LOWER('Hello World') FROM dual;


-- Q. last_name�� seo�� ��� ã��
select last_name, salary
from employees
where LOWER(last_name) = 'seo';


-- Q. job_id�� ���� ���̸� ���ϼ���.
SELECT job_id, length(job_id) FROM employees;


-- SUBSTR(���ڿ�, ������ġ, ����) : ������ġ���� ������ŭ ���
SELECT SUBSTR('Hello World',3,3) FROM dual;

-- �ڿ��� ���� �̱� : ������ġ�� ���̳ʽ� ��
SELECT SUBSTR('Hello World',-3,3) FROM dual;


-- LPAD(���ڿ�, ��ü ���� ��, ���鿡 ä�� ����) -> ��ü ���� ������ ���ڿ��� ä��� ���� ���� ���� '���鿡 ä�� ����'�� ���ʿ� ä��
-- ������ ���� �� ���ʿ� ���ڸ� ä���.
SELECT LPAD('Hello World',20,'#') FROM dual;

-- ���� ���� �� �����ʿ� ���ڸ� ä���.
SELECT RPAD('Hello World',20,'#') FROM dual;


-- TRIM : ��� ���ڿ����� ������ ���� ����
SELECT last_name,TRIM('A' FROM last_name) FROM employees;

-- LTRIM : ��� ���ڿ����� ���ʺ��� ������ ���� ����
SELECT LTRIM('aaaHello Worldaaa', 'a') From dual;

-- RTRIM : ��� ���ڿ����� �����ʺ��� ������ ���� ����
SELECT RTRIM('aaaHello Worldaaa', 'a') From dual;

-- �������
SELECT TRIM('   Hello World   ') From dual;
SELECT LTRIM('   Hello World   ') From dual;
SELECT RTRIM('   Hello World   ') From dual;



-- ��¥ �Լ� --


-- ���� ��¥ --
SELECT SYSDATE FROM dual;

-- Q. �ټ��ϼ� ���ϱ�
SELECT last_name, TRUNC(SYSDATE-hire_date,0) �ټ��ϼ� FROM employees;

-- Q. �ټӿ��� ���ϱ�
SELECT last_name, TRUNC((SYSDATE-hire_date)/365,0) �ټӿ��� FROM employees;


-- ADD_MONTHS : Ư�� ���� ���� ���� ��¥�� ���Ѵ�. --
SELECT last_name, ADD_MONTHS(hire_date,6) FROM employees;


-- LAST_DAY : �ش� ��¥�� ���� ���� ������ ��ȯ�ϴ� �Լ� --
SELECT LAST_DAY(SYSDATE) FROM dual;


-- Q. ���� �� ����
SELECT last_name, hire_date, LAST_DAY(ADD_MONTHS(hire_date,1)) FROM employees;


-- NEXT_DAY : �Է��� ��¥ �������� ���� ������ ��¥ / (�� ~ �� : 1 ~ 7) --
SELECT hire_date, NEXT_DAY(hire_date, '��') FROM employees;
SELECT hire_date, NEXT_DAY(hire_date, 2) FROM employees;


-- MONTHS_BETWEEN() : ��¥�� ��¥ ������ ���� ���� ���Ѵ�. --
-- Q. �ټӿ��� ���ϱ�
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date),0) �ټӿ��� FROM employees;


-- Q. �Ի����� 6���� �� ù ��° �������� ���ϼ���.
SELECT last_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),2) D_DAY FROM employees;



-- �����Լ� Aggregate Functions : sum(), avg(), max() min() count()

-- Q. job_id ���� �����հ� ������� �ְ��� �������� �ο��� ���
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������, COUNT(*) �ο���
FROM employees
GROUP BY job_id;

-- Q. job_id ���� �����հ� ������� �ְ��� �������� �ο��� ���, �� ��տ����� 5000 �̻��� ��츸 ����
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������, COUNT(*) �ο���
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000;

-- Q. job_id ���� �����հ� ������� �ְ��� �������� �ο��� ���, �� ��տ����� 5000 �̻��� ��츸 ����, ������� �������� ��������
SELECT job_id, SUM(salary) �����հ�, AVG(salary) �������, MAX(salary) �ְ���, MIN(salary) ��������, COUNT(*) �ο���
FROM employees
GROUP BY job_id
HAVING AVG(salary) >= 5000
ORDER BY AVG(salary) DESC;


-- ���� Join
-- �����ȣ�� 110�� ����� �μ����� �˰� ���� ���
SELECT * FROM employees WHERE employee_id=110;
SELECT * FROM departments WHERE department_id=110;

-- WHERE ���
SELECT employee_id, department_name FROM employees E, departments D WHERE E.department_id = D.department_id AND employee_id=110;

-- JOIN ���
SELECT employee_id, department_name FROM employees E join departments D on E.department_id=D.department_id WHERE employee_id=110;


-- Q. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���.
-- join~on, where�� �����ϴ� �� ���� ��� ���.

-- WHERE ���
SELECT * FROM employees;
SELECT * FROM jobs;

SELECT employee_id, last_name || ' ' || first_name name, J.job_id, job_title 
FROM employees E, jobs J
WHERE E.job_id = J.job_id and employee_id=120;

-- JOIN ���
SELECT employee_id, last_name || ' ' || first_name name, J.job_id, job_title 
FROM employees E join jobs J on E.job_id = J.job_id
WHERE E.job_id = J.job_id and employee_id=120;


-- ����ũ�� ������ �տ� ���̺���ڸ� �ٿ����� �ʾƵ� �� :-)
SELECT employee_id, job_title, department_name
FROM employees E, jobs J, departments D
WHERE E.job_id = J.job_id
AND E.department_id = D.department_id;



-- 3�� ���̺� �����غ���!
SELECT *  
FROM countries C, regions R, locations L 
WHERE C.region_id=R.region_id and C.country_id=L.country_id;

SELECT D.department_name, L.city, ROUND(AVG(E.salary)) avg_salary, TRUNC(AVG(SYSDATE-hire_date)/365) avg_year
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.department_id = D.department_id AND L.location_id = D.location_id
GROUP BY L.city, D.department_name;

-- ���ƴ�
SELECT E.last_name, L.city, L.street_address FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.department_id = D.department_id AND L.location_id = D.location_id;


-- self join �ϳ��� ���̺��� �� ���� ���̺��� ��ó�� ����
SELECT E.employee_id ���, E.last_name �̸�, M.last_name, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.employee_id;

-- �̰� �ȵ�!
SELECT *
FROM employees;
WHERE employee_id = manager_id;


-- outer join : ���� ���ǿ� �������� ���ϴ��� �ش� ���� ��Ÿ���� ���� �� ���
SELECT E.employee_id ���, E.last_name �̸�, M.last_name ���, M.manager_id �μ���
FROM employees E, employees M
WHERE E.employee_id = M.manager_id(+)
ORDER BY �̸�;


-- UNION(������) INTERSECT(������) MINUS(������) UNION ALL(��ġ�� �ͱ��� ����) --

-- UNION(������) --
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary < 5000
UNION
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

-- UNION ALL(��ġ�� �ͱ��� ����) --
-- �ߺ� ����(??????????)

-- INTERSECT(������) --
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary > 15000
INTERSECT
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';

-- MINUS(������) --
SELECT first_name �̸�, salary �޿� FROM employees
WHERE salary > 15000
MINUS
SELECT first_name �̸�, salary �޿� FROM employees
WHERE hire_date < '02/01/01';


-- all : ���� ������ �� ������ ���� ������ �˻� ������� ��� ��ġ�ϸ� ��.
-- Q. 100�� �μ��� ������ ����� �޿����� �� ���� �޿��� �޴� ����� ���
SELECT last_name, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE department_id=100);

-- any : ���� ������ �� ������ ���� ������ �˻� ������� �ϳ� �̻� ��ġ�ϸ� ��.
SELECT last_name, salary FROM employees WHERE salary > any
(SELECT salary FROM employees WHERE department_id=100);





--[����_0812] --

--Q1. 2005�� ���Ŀ� �Ի��� ������ ���, �̸�, �Ի���, �μ���(department_name),������(job_title)�� ���
SELECT employee_id ���, last_name �̸�, hire_date �Ի���, department_name �μ���, job_title ������
FROM employees E, departments D, jobs J
WHERE E.department_id=D.department_id AND E.job_id=J.job_id AND TO_CHAR(hire_date,'yy')>=05;

-- �ٸ���--
SELECT employee_id ���, last_name �̸�, hire_date �Ի���, department_name �μ���, job_title ������
FROM employees E, departments D, jobs J
WHERE E.department_id=D.department_id AND E.job_id=J.job_id AND hire_date >= '05/01/01';

-- Q2. job_title, department_name ���� ��� ������ ���� �� ����ϼ���.
SELECT job_title, department_name, AVG(salary)
FROM employees E, departments D, jobs J
WHERE E.department_id=D.department_id AND E.job_id=J.job_id
GROUP BY job_title, department_name;

--Q3. ��պ��� ���� �޿��� �޴� ���� �˻� �� ����ϼ���.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--Q4. last_name�� King�� ������ last_name,hire_date,department_id�� ����ϼ���
SELECT last_name, hire_date, department_id
FROM employees
WHERE last_name LIKE 'King';

--Q5. ���, �̸�, ������ ����ϼ���. �� ������ �Ʒ� ���ؿ� ����
-- salary > 20000 then '��ǥ�̻�'
-- salary > 15000 then '�̻�'
-- salary > 10000 then '����'
-- salary > 5000 then '����'
-- salary > 3000 then '�븮'
-- ������ '���'
SELECT employee_id ���, last_name �̸�, 
CASE WHEN salary > 20000 THEN '��ǥ�̻�'
     WHEN salary > 15000 THEN '�̻�'
     WHEN salary > 10000 THEN '����'
     WHEN salary > 5000 THEN '����'
     WHEN salary > 3000 THEN '�븮'
     ELSE '���'
     END AS ����
FROM employees;
-- if~elif~else���ǹ��� ���� �뵵!

--Q6.employees ���̺�� ���� last_name,salary,�ְ����� ����ϼ���.
-- ��, �ְ����� first_value ~over �� ���Ѵ�.
SELECT last_name, salary, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) �ְ���
FROM employees;

--Q.7 �μ��� ���� ������ ����ϼ���.
--������--
SELECT last_name, salary, job_id, RANK() OVER(PARTITION BY job_id ORDER BY salary DESC) "���� ����"
FROM employees
ORDER BY job_id;

--������--
SELECT e.last_name �̸�, d1.department_name �μ���, e.salary ����,
RANK() OVER(PARTITION BY d1.department_name ORDER BY e.salary DESC) AS "�μ��� ���� ����"
FROM employees e, departments d1, departments d2
WHERE e.department_id = d1.department_id AND d1.department_id = d2.department_id;

--Q8.employees ���̺��� employee_id�� salary�� �����ؼ� employee_salary ���̺��� �����ϼ���.
CREATE TABLE employee_salary 
AS SELECT employee_id, salary
FROM employees;

SELECT * FROM employee_salary;

--Q9. employee_salary ���̺� first_name,last_name �÷��� �߰��ϼ���.
ALTER TABLE employee_salary ADD(
first_name VARCHAR2(40),
last_name VARCHAR2(40));
desc employee_salary;

UPDATE employee_salary a 
SET (a.first_name, a.last_name) = 
(SELECT b.first_name, b.last_name FROM employees b WHERE a.employee_id = b.employee_id);

SELECT *
FROM employee_salary;

--Q10.last_name�� name���� �����ϼ���
ALTER TABLE employee_salary RENAME COLUMN last_name TO name;

--Q11. employees_salary ���̺��� employee_id�� �⺻Ű�� �����ϰ� CONSTRAINT_NAME�� ES_PK�� ���� ��
-- ����ϼ���.
ALTER TABLE employee_salary ADD CONSTRAINT ES_PK PRIMARY KEY(employee_id);

--Q12. employee_salary ���̺��� employee_id���� CONSTRAINT_NAME�� ���� �� ���� ���θ� Ȯ���ϼ���.
ALTER TABLE employee_salary DROP CONSTRAINT ES_PK;