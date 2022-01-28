/* 08월 10일 */

/* 문법은 대문자로 쓰면 가독성이 좋음 */
/* SELECT - 조회 */
SELECT * FROM book;

SELECT bookname, price FROM book;

-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT bookid, bookname, publisher, price FROM book;

SELECT publisher FROM book;

-- 중복제거 --
SELECT DISTINCT publisher FROM book; 

-- WHERE : 조건 --
SELECT *
FROM book
WHERE price < 10000;

-- Q. 가격이 10000 이상 20000 이하인 도서를 검색하시오. --
SELECT *
FROM book
WHERE price BETWEEN 10000 and 20000;

SELECT *
FROM book
WHERE price >= 10000 and price <= 20000;

-- Q. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. --
SELECT *
FROM book
WHERE publisher IN ('굿스포츠','대한미디어');

SELECT *
FROM book
WHERE publisher = '굿스포츠' or publisher = '대한미디어';

-- Q. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오. --
SELECT *
FROM book
WHERE publisher NOT IN ('굿스포츠','대한미디어');

-- 특정 패턴을 지닌 값 골라내기 --
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구의 역사';

-- Q. 도서이름에 '축구'가 포함된 출판사를 검색하시오.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%축구%'; -- %는 0번 이상 발생하는 것--

-- Q. 도서이름의 왼쪽 두 번째 위치에 '-구'라는 문자열을 갖는 도서를 검색하시오. --
-- 특정위치는 _(언더바)를 사용! --
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '_구%';

-- Q. 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오. --
SELECT *
FROM book
WHERE bookname LIKE '%축구%' and price >= 20000;

-- bookname 기준으로 정렬해서 검색 --
SELECT *
FROM book
ORDER BY bookname;

-- Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오. --
SELECT *
FROM book
ORDER BY price, bookname;

-- ASC - 오름차순(디폴트) --
--DESC - 내림차순 --

-- Q. 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오. --
SELECT *
FROM book
ORDER BY price DESC, publisher;

SELECT * FROM orders;

-- 판매가격의 합 --
SELECT SUM(saleprice)
FROM orders;

-- 판매가격의 합, 컬럼이름 총매출로 뽑기! --
-- 컬럼명에 띄어쓰기 쓰려면 쌍따옴표 안에 넣기 --
SELECT SUM(saleprice) AS "총 매출"
FROM orders;

-- Q. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오. --
SELECT SUM(saleprice) AS "총 판매액"
FROM orders
WHERE custid = 2;

-- 총합, 평균, 최소, 최대 --
SELECT SUM(saleprice) AS total,
    AVG(saleprice) AS average,
    MIN(saleprice) AS minimum,
    MAX(saleprice) AS maximum
FROM orders;

-- orders의 행 수--
SELECT COUNT(*)
FROM orders;

SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

-- Q. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.--
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid;

-- 단, 두 권 이상 구매한 고객만 구하시오. --
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >=2;

-- 두 테이블 한 번에 불러오기 / 지정한 컬럼 같은 것끼리 매칭시켜서 불러오기 --
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;

-- Q. 곡객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.--
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

-- Q. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오. --
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid = orders.custid;

-- Q. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT name, SUM(saleprice) "총 판매액"
FROM customer C, orders O
WHERE C.custid = O.custid
GROUP BY C.name
ORDER BY C.name;

-- AS생략가능--
SELECT custid, SUM(saleprice) "총 판매액"
FROM orders
GROUP BY custid
ORDER BY custid;

-- Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid and O.bookid = B.bookid
ORDER BY C.name;

-- Q. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT C.name, B.bookname
FROM customer C, book B, orders O
WHERE C.custid = O.custid AND O.bookid = B.bookid AND B.price = 20000;

-- Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- (+) 사용 --
SELECT C.name, O.saleprice
FROM customer C, orders O
WHERE C.custid = O.custid(+);

-- JOIN 사용 --
SELECT customer.name, orders.saleprice
FROM customer LEFT OUTER JOIN orders ON customer.custid=orders.custid;

-- Q. 가장 비싼 도서의 이름을 보이시오.
-- 부속질의 사용 --
SELECT bookname
FROM book
WHERE price=(SELECT MAX(price) FROM book);

-- Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오. --
SELECT DISTINCT C.name
FROM customer C, orders O
WHERE C.custid = O.custid;

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

-- Q. '대한미디어'에서 출판한 도서를 구매한 고객의 이름을 보이시오. --
SELECT C.name
FROM customer C, book B, orders O
WHERE C.custid = O.custid and O.bookid = B.bookid and B.publisher = '대한미디어';

SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders
WHERE bookid IN(SELECT bookid FROM book
WHERE publisher = '대한미디어'));



-- Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오. --

--같은 테이블을 두 테이블로 나눈 후 연결시켜서 구하기!--
SELECT b1.bookname
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) 
FROM book b2 WHERE b2.publisher = b1.publisher);

-- Q. 도서를 주문하지 않은 고객의 이름을 보이시오. --
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

-- Q. 주문이 있는 고객의 이름과 주소를 보이시오. --
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

--DDL - 제약조건 종류
-- PRIMARY KEY(기본키) :
-- UNIQUE(고유키) : 
-- NOT NULL : 
-- CHECK : 입력할 수 있는 값의 범위 등을 제한한다. CHECK 제약으로는 TRUE of FALSE 로 평가할 수 있는 논리식을 지정한다.
-- FOREIGN KEY(외래키): 다른 테이블과 연결되는 키--

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
-- FOREIGN KEY의 REFERENCES 인 다른 table의 컬럼은 PRIMARY KEY!

-- 새로운 속성 추가(ALTER, ADD)
ALTER TABLE newbook ADD isbn VARCHAR2(15);




--[과제_0810]--

-- Q. NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.
ALTER TABLE newbook MODIFY isbn NUMBER;

-- Q. NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE newbook DROP COLUMN isbn;

-- Q. NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
desc newbook;
ALTER TABLE newbook MODIFY bookid NOT NULL;

-- Q. newbookd 테이블의 기본키를 삭제한 후 다시 bookid 속성을 기본키로 변경하시오
ALTER TABLE newbook DROP PRIMARY KEY;
ALTER TABLE newbook MODIFY bookid PRIMARY KEY;

-- Q. NewBook 테이블을 삭제하시오.
DROP TABLE newbook;



-- 08월 11일 --

SELECT * FROM customer;

-- Q. Customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.--
UPDATE customer
SET address = '대한민국 부산'
WHERE custid = 5;

SELECT * FROM customer;

-- Q. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer
SET address = (SELECT address FROM customer WHERE name = '김연아')
WHERE name = '박세리';

SELECT * FROM customer;

-- Q. Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE customer
WHERE custid = 5;

-- Q. 모든 고객을 삭제하시오.
-- ORDERS 에서 참조하고 있으므로 바로 DELETE 하면 안 지워짐.
DELETE customer;
