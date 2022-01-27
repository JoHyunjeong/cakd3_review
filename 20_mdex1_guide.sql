/* 08�� 10�� */

/* ������ �빮�ڷ� ���� �������� ���� */
/* SELECT - ��ȸ */
SELECT * FROM book;

SELECT bookname, price FROM book;

-- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT bookid, bookname, publisher, price FROM book;

SELECT publisher FROM book;

-- �ߺ����� --
SELECT DISTINCT publisher FROM book; 

-- WHERE : ���� --
SELECT *
FROM book
WHERE price < 10000;

-- Q. ������ 10000 �̻� 20000 ������ ������ �˻��Ͻÿ�. --
SELECT *
FROM book
WHERE price BETWEEN 10000 and 20000;

SELECT *
FROM book
WHERE price >= 10000 and price <= 20000;

-- Q. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. --
SELECT *
FROM book
WHERE publisher IN ('�½�����','���ѹ̵��');

SELECT *
FROM book
WHERE publisher = '�½�����' or publisher = '���ѹ̵��';

-- Q. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�. --
SELECT *
FROM book
WHERE publisher NOT IN ('�½�����','���ѹ̵��');

-- Ư�� ������ ���� �� ��󳻱� --
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '�౸�� ����';

-- Q. �����̸��� '�౸'�� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%�౸%'; -- %�� 0�� �̻� �߻��ϴ� ��--

-- Q. �����̸��� ���� �� ��° ��ġ�� '-��'��� ���ڿ��� ���� ������ �˻��Ͻÿ�. --
-- Ư����ġ�� _(�����)�� ���! --
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_��%';

-- Q. �౸�� ���� ���� �� ������ 20000�� �̻��� ������ �˻��Ͻÿ�. --
SELECT *
FROM book
WHERE bookname LIKE '%�౸%' and price >= 20000;

-- bookname �������� �����ؼ� �˻� --
SELECT *
FROM book
ORDER BY bookname;

-- Q. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�. --
SELECT *
FROM book
ORDER BY price, bookname;

-- ASC - ��������(����Ʈ) --
--DESC - �������� --

-- Q. ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�. --
SELECT *
FROM book
ORDER BY price DESC, publisher;

SELECT * FROM orders;

-- �ǸŰ����� �� --
SELECT SUM(saleprice)
FROM orders;

-- �ǸŰ����� ��, �÷��̸� �Ѹ���� �̱�! --
-- �÷��� ���� ������ �ֵ���ǥ �ȿ� �ֱ� --
SELECT SUM(saleprice) AS "�� ����"
FROM orders;

-- Q. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�. --
SELECT SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE custid = 2;

-- ����, ���, �ּ�, �ִ� --
SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

-- orders�� �� ��--
SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

-- Q. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.--
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid;

-- ��, �� �� �̻� ������ ���� ���Ͻÿ�. --
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >=2;

-- �� ���̺� �� ���� �ҷ����� / ������ �÷� ���� �ͳ��� ��Ī���Ѽ� �ҷ����� --
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;

-- Q. ��� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.--
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

-- Q. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�. --
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid = orders.custid;

-- Q. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT name, SUM(saleprice) "�� �Ǹž�"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

-- AS��������--
SELECT custid, SUM(saleprice) "�� �Ǹž�"
FROM orders
GROUP BY custid
ORDER BY custid;

-- Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid and O.bookid = B.bookid
ORDER BY C.name;

-- Q. ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

-- Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
-- (+) ��� --
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

-- JOIN ��� --
SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

-- Q. ���� ��� ������ �̸��� ���̽ÿ�.
-- �μ����� ��� --
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price) FROM book);

-- Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�. --
SELECT DISTINCT C.name
FROM customer C, orders O
WHERE C.custid = O.custid;

--������--
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

-- Q. '���ѹ̵��'���� ������ ������ ������ ���� �̸��� ���̽ÿ�. --
SELECT C.name
FROM customer C, book B, orders O
WHERE C.custid = O.custid and O.bookid = B.bookid and B.publisher = '���ѹ̵��';

--������--
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '���ѹ̵��'));



-- Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�. --

--������--
--���� ���̺��� �� ���̺�� ���� �� ������Ѽ� ���ϱ�!--
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) 
FROM book b2 WHERE b2.publisher = b1.publisher);

-- Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�. --
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

-- Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�. --
SELECT DISTINCT C.name, C.address
FROM customer C, orders O
WHERE C.custid = O.custid;

SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name, address
FROM customer cs
WHERE EXISTS(SELECT * FROM orders od
WHERE cs.custid = od.custid);

--DDL - �������� ����
-- PRIMARY KEY(�⺻Ű) :
-- UNIQUE(����Ű) : 
-- NOT NULL : 
-- CHECK : �Է��� �� �ִ� ���� ���� ���� �����Ѵ�. CHECK �������δ� TRUE of FALSE �� ���� �� �ִ� ������ �����Ѵ�.
-- FOREIGN KEY(�ܷ�Ű): �ٸ� ���̺�� ����Ǵ� Ű--

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000));
DROP TABLE newbook;

CREATE TABLE newbook(
bookid NUMBER,
bookname VARCHAR2(20) NOT NULL,
publisher VARCHAR2(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price>1000),
PRIMARY KEY (bookid));

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);
-- FOREIGN KEY�� REFERENCES �� �ٸ� table�� �÷��� PRIMARY KEY!

-- ���ο� �Ӽ� �߰�(ALTER, ADD)
ALTER TABLE newbook ADD isbn VARCHAR2(15);




--[����_0810]--

-- Q. NewBook ���̺��� isbn �Ӽ��� ������ Ÿ���� NUMBER������ �����Ͻÿ�.
ALTER TABLE newbook MODIFY isbn NUMBER;

-- Q. NewBook ���̺��� isbn �Ӽ��� �����Ͻÿ�.
ALTER TABLE newbook DROP COLUMN isbn;

-- Q. NewBook ���̺��� bookid �Ӽ��� NOT NULL ���������� �����Ͻÿ�.
desc newbook;
ALTER TABLE newbook MODIFY bookid NOT NULL;

-- Q. newbookd ���̺��� �⺻Ű�� ������ �� �ٽ� bookid �Ӽ��� �⺻Ű�� �����Ͻÿ�
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook MODIFY bookid PRIMARY KEY;

-- Q. NewBook ���̺��� �����Ͻÿ�.
DROP TABLE newbook;



-- 08�� 11�� --

SELECT * FROM customer;

-- Q. Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�.--
UPDATE customer
SET address = '���ѹα� �λ�'
WHERE custid = 5;

SELECT * FROM customer;

-- Q. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '�迬��')
WHERE name = '�ڼ���';

SELECT * FROM customer;

-- Q. Customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
DELETE customer
WHERE custid = 5;

-- Q. ��� ���� �����Ͻÿ�.
-- ORDERS ���� �����ϰ� �����Ƿ� �ٷ� DELETE �ϸ� �� ������.
DELETE customer;