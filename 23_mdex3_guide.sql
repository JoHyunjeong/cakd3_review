-- 08��13�� --

-- ����� ���� TEST
-- Tablespace users�� �⺻���� ����
-- ����Ŭ�н��뼭������ �ؾ� ��
CREATE USER C##TEST
IDENTIFIED BY TEST
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

-- ���Ѻο�
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;

-- ����� ��ȣ ����
ALTER USER C##TEST
IDENTIFIED BY TEST1;

-- ���� ȸ��
REVOKE CREATE SYNONYM FROM C##TEST;
REVOKE CREATE SESSION, CREATE TABLE, CREATE VIEW FROM C##TEST;

-- ����� ����
DROP USER C##TEST;


-- �� ���� �ϱ�
-- CASCADE : ����Ȱ� ������ �� ������
-- PROFILE�� DEFAULT�� �����ϰ� �Ǹ� ��� �ڿ��� ������ ����� �� �ְ� �ȴ�.
-- : ��, ����Ŭ ��ġ �� DBA� ���Ͽ� DEFAULT PROFILE�� ������ ���� ������ PROFILE�� ����ǰ� �ȴ�.
DROP USER C##TEST CASCADE;
CREATE USER C##TEST IDENTIFIED BY TEST DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO C##TEST;
GRANT CREATE VIEW, CREATE SYNONYM TO C##TEST;
GRANT UNLIMITED TABLESPACE TO C##TEST;
ALTER USER C##TEST ACCOUNT UNLOCK;


SELECT USERNAME
,ACCOUNT_STATUS
,LOCK_DATE
,EXPIRY_DATE
,DEFAULT_TABLESPACE
FROM DBA_USERS
WHERE USERNAME='C##TEST';

DROP USER C##TEST CASCADE;

--CASCADE�� ����ϰ� �Ǹ� ����� �̸��� ���õ� ��� �����ͺ��̽� ��Ű���� ������ �������κ��� �����Ǹ�
--��� ��Ű�� ��ü�� ���� ���������� �����ȴ�.
--(��Ű��:��Ÿ������? ����..��;)

DROP TABLE member;
DROP TABLE member1;

CREATE TABLE member(
ID VARCHAR2(50) NOT NULL,
PWD VARCHAR2(50),
NAME VARCHAR2(50),
GENDER NCHAR(2), --���ڼ�(�ѱ��� �� ���ڿ� 2����Ʈ, ���ڼ����ϸ� ����)
AGE NUMBER,
BIRTHDAY CHAR(10), --2000-01-02
PHONE CHAR(13), --010-1234-2345
REGDATE DATE);

INSERT INTO member VALUES ('200901','111','shin','����',24,'1998-01-01','010-0000-0000',SYSDATE);
SELECT * FROM member;

--Q. MEMBER ���̺��� �����ؼ� MEMBER1 ���̺��� ���� �� ����ϼ���.
CREATE TABLE member1
AS SELECT * FROM member;
SELECT * FROM member1;

SELECT * FROM TABS;

INSERT INTO member1(ID,PWD,NAME) VALUES ('200901','111','kevin');
INSERT INTO member1 (ID,PWD,NAME,GENDER) VALUES('200902','123','dragon','����');

SELECT * FROM member1;

-- Q1. ID, NAME�� �ڷ� ũ�� ������ ���ڼ� �������� �����ϼ���.
-- Nchar, Nvarchar2 ũ���� ������ Byte�� �ƴ϶� ���ڼ��� ��Ÿ��.
ALTER TABLE member1 MODIFY(ID NVARCHAR2(50), NAME NVARCHAR2(50));

-- Q2. PWD�� �������� NOT NULL�� �߰��ϰ� �������� �̸��� MEMBER1_NN���� �����ϼ���.
--ALTER TABLE member1 MODIFY PWD NOT NULL;
ALTER TABLE member1 MODIFY(PWD CONSTRAINT MEMBER1_NN NOT NULL);

--Q3. BIRTHDAY �÷� �̸��� BD�� �����ϼ���.
ALTER TABLE member1 RENAME COLUMN birthday TO BD;

--Q4. AGE �÷��� �����ϼ���.
ALTER TABLE member1 DROP COLUMN AGE;

--Q5. TEXT �÷��� �߰��ϼ���. ��, �ڷ� ���´� NCLOB
ALTER TABLE member1 ADD TEXT NCLOB;

--Q6. ID�� �������� �̸� MEMBER_PK�� �⺻Ű�� �����ϼ���.
ALTER TABLE member1 ADD CONSTRAINT MEMER_PK PRIMARY KEY(ID);

--Q7. ID�� ������ �⺻Ű ���������� �����ϼ���.
ALTER TABLE MEMBER1 DROP CONSTRAINT MEMBER_PK;

--Q8. MEMBER1�� ��� ���� �����ϼ���.
TRUNCATE TABLE MEMBER1;




--COMMIT, ROLLBACK
DROP TABLE users;
CREATE TABLE users(
id NUMBER,
name VARCHAR(20),
age NUMBER);

INSERT INTO users VALUES(1,'HONG GILDONG',30);

DELETE FROM users WHERE id=1;

ROLLBACK;
COMMIT;
SELECT * FROM users;
