-----------------------------------------------------------------------------
	테이블
-----------------------------------------------------------------------------

▶ 자료형
▷ 문자타입
    char	고정형 문자타입		
		2000byte 까지 저장 가능. 
		지정한 길이 보다 짧은 데이터가 올 경우 나머지 공간은 공백으로 채운다.
				    			
    varchar2	가변형 문자타입
		4000byte 까지 저장 가능.	
		지정한 길이 보다 짧은 데이터가 올 경우 지정한 길이만큼 공간이 생성된다.

    LOB		텍스트 그래픽 이미지 동영상 사운드와 같이 구조화 되지 않은 대용량 데이터를 저장
		4GB까지 저장 가능.
		BLOB 			바이너리 데이터 
		CLOB 			대용량 텍스트 데이터 
		NCLOB			국가별 문자셋 데이터를 저장
		BFILE 			대용량 바이너리 데이터를 파일 형태로 저장
 
    Nchar , Nvarchar2	크기의 단위가 Byte가 아니라 글자수를 나타냄

▷ 숫자타입 		
    number (정수 및 실수 모두 포함)
    number(5) 		-> -99999 ~ 99999
    number(3) 		-> -999 ~ 999
    number(5,2) 	-> -999.99 ~ 999.99
    number(6,3) 	-> -999.999 ~ 999.999
	
▷ 날짜타입
    date
    timestamp		date의 확장형태

▷ 인코딩
    ASCII
    영문/숫자/기호 1글자는 1바이트, 한글/한자 1글자는 2바이트
    영문과 또 다른 하나의 언어만 사용할 수 있습니다.
    하나의 파일에 여러 언어를 동시에 표현할 수 없습니다.
    컴퓨터 초창기부터 사용해 왔기에, 호환성이 좋습니다.

    euc-kr
    영문/숫자/기호 1글자는 1바이트, 한글/한자 1글자는 2바이트
    영문, 한글, 한국에서 사용되는 한자만 표현. 즉, 특수 외국어 문자, 일본식/중국식 한자는 표현할 수 없습니다.
    하나의 파일에 여러 언어를 동시에 표현할 수 없습니다.
    컴퓨터 초창기부터 사용해 왔기에, 호환성이 좋습니다. 

    Unicode	
    각 나라는 별도의 문자셋을 갖고 있습니다. 한글은 KSC5601.
    각 나라의 문자셋을 표준화한 결과물이 유니코드.
		
    영문/숫자/기호/한글/한자 1글자는 2바이트, 파일에 저장시에도 2바이트
    모든 언어가 표현 가능합니다.
    하나의 파일에 모든 언어를 표현할 수 있습니다. 단 각 언어에 대한 폰트가 설치되어 있어야 가능합니다.

    UTF-8
    1byte 기반에서 확장	. ASCII와 호환을 위해 1byte에 저장.	
    영문/숫자/기호 1글자는 1바이트, 한글/한자 1글자는 3바이트, 파일에 저장시에도 3바이트
    모든 언어가 표현 가능합니다. 
    하나의 파일에 모든 언어를 표현할 수 있습니다. 단 각 언어에 대한 폰트가 설치되어 있어야 가능합니다.
  
    UTF-16
    2byte 기반에서 확장. 넘는 문자는 4byte
    영문/숫자/기호/한글/한자 1글자는 2바이트
    영어가 2byte로 표현되는 문제가 있다.


-----------------------------------------------------------------------------
	DDL
-----------------------------------------------------------------------------

▶ DDL Data Definition Language
▷ 테이블 생성
    create table 테이블명( 컬럼명 자료형 );

    create table test1 (
	eno number( 4 ),
	ename varchar2( 20 ),
	esal number( 7, 2 )
    );

▷ 테이블 복사
    create table test2 as select * from test1;
    다른 테이블의 구조 뿐아니라 데이터까지 복사해서 새로운 테이블 생성
    기존 테이블의 컬럼만 선택해서 생성할 수도 있다.

▷ 테이블 구조 복사
    create table test3 as select * from test1 where 1=0;
    where 조건절에 거짓 조건을 지정하면 해당 로우를 발견하지 못하기 때문에 
    로우가 없는 빈 테이블을 생성한다.
		
▷ 컬럼 추가하기
    alter table test1 add( email varchar2( 10 ) );
	
▷ 컬럼 변경하기	
    alter table test1 modify( email varchar2( 40 ) );
	
    데이터가 존재할 경우 데이터 타입을 변경할 수 없다. 
    단 char와 varchar2 는 가능하다.
    크기는 기존 데이터보다 같거나 크게 변경만 가능하다.

▷ 컬럼 삭제하기
    alter table test1 drop column email;
	
▷ 컬럼 비활성화
    alter table test1 set unused( email );
    컬럼을 삭제할 경우 사용중일 수도 있기 때문에 
    일단 논리적으로 제한한 후 사용빈도가 적은 시간에 실제 삭제 작업을 한다.
    delete와 같이 다시 사용할 수 없다.

    select * from user_unused_col_tabs;
    컬럼 개수 확인	

    alter table test1 drop unused columns;
    unused column 모두 삭제

▷ 테이블의 모든 로우 삭제
    truncate table test1;
	
▷ 테이블 삭제
    drop table test1;

	
-----------------------------------------------------------------------------
	DML
-----------------------------------------------------------------------------

▶ DML Data Manipulation Language
▷ insert
    데이블에 데이터를 입력하기 위해 사용하는 데이터 조작어

    insert into 테이블명 [컬럼명] values [값]
    컬럼명에 기술된 목록수와 values 다음에 나오는 값의 개수가 같아야 한다.
    테이블의 모든 컬럼을 다 입력하는 경우는 컬럼명을 기술하지 않는다.
    컬럼명과 값을 생략하는 경우 해당 컬럼에는 NULL 값이 입력됩니다.
    NULL값을 직접지정하거나 ‘’를 대신 사용하는 것도 가능하다.
	
    insert into test1 select * from test2;
    다른 테이블의 리턴되는 로우 수만큼 테이블에 추가한다.

    create table commission(
    employee_id number( 3 ),
    bonus number( 8, 2)
    );
    insert into commission select employee_id, salary * 0.1 from employees;

    여러 테이블에 한 번에 insert
    create table employees80 as select * from employees where 0=1;
    create table employees90 as select * from employees80;
    create table employees100 as select * from employees90;

    select * from employees80;	데이터가 없다
    select * from employees90;	데이터가 없다
    select * from employees100;	데이터가 없다

    INSERT [ALL or FIRST]	
	WHEN 조건1 THEN INTO 테이블명1
	WHEN 조건2 THEN INTO 테이블명2
	...
	ELSE INTO 테이블명0
    SELECT 구문;

    all과 first의 차이는 교집합이 발생할 경우
    all은 양쪽 조건 모두에 데이터를 넣고
    first는 선행 조건에만 데이터를 넣는다.

    insert all
    when department_id = 80 then into employees80 
    when department_id = 90 then into employees90 
    when department_id = 100 then into employees100
    select * from employees; 

    select * from employees80;
    select * from employees90;
    select * from employees100;

▷ update
    update 테이블명 set 컬럼명=변경할 값 where 조건

    update test1 set ( dname, loc ) = ( select dname, loc from test2 where deptno=40 ) where deptno=20;
    다른 테이블의 값을 이용해서 값 변경하기

    update test set esal 
    = ( select salary from employees where last_name = 'Seo' )
    where esal is null;

▷ delete
    delete from 테이블명 where 조건
	
    delete from test1 where deptno = ( select deptno from test2 where dname=’sales’ );
    현재 테이블에 부서명이 없을 경우 다른 테이블의 부서명으로 부서번호를 검색해서 현재 테이블에 적용한다.


-----------------------------------------------------------------------------
	트랜잭션
-----------------------------------------------------------------------------

▶ 트랜잭션 관리	
    트랜잭션 데이터 처리의 한 단위를 의미한다.
    하나의 트랜잭션은 All-Or-Nothing 방식으로 처리된다.
    여러 개의 명령이 모두 정상적으로 처리되면 정상 종료 하고
    하나라도 비정상적으로 처리되면 모두를 취소한다.

    commit		저장되지 않은 모든 테이터베이스를 저장하고 현재의 트랜잭션을 종료한다.
			트랜잭션 처리과정이 모두 반영되며 하나의 트랜잭션 과정이 끝난다.
    savepoint 이름;	현재까지의 트랜잭션을 특정 이름으로 지정하는 명령
    rollback [to 이름]	저장되지 않은 데이터를 모두 취소하고 트랜잭션을 종료한다.
			savepoint 로 지정한 위치로 돌아간다.
	
    create alter drop 등은 자동 커밋이 발생한다.
	

-----------------------------------------------------------------------------
	제약 조건 Constraints
-----------------------------------------------------------------------------

▶ 무결성 제약 조건
    테이블에 부적절한 자료가 입력되는 것을 방지하기 위해 테이블을 생성할 때 컬럼에 정의하는 규칙

    not null	해당 컬럼 값으로 NULL을 허용하지 않는다.
    unique	해당 컬럼 값은 항상 유일무이한 값을 가진다.
    primary key	해당 컬럼 값은 반드시 존재해야 하고 유일해야 한다.
		not null과 unique를 결합한 형태
    foreign key	해당 컬럼 값이 타 컬럼의 값을 참조해야 한다.
		참조되는 컬럼에 없는 값은 입력 불가
    check	해당 컬럼에 저장 가능한 데이터 값의 범위나 사용자 조건을 지정

    제약 조건 확인하기
    select * from user_constraints;

    P 		primary key
    R 		foreign key
    C 		check, not null

    제약조건 이름은 테이블명_컬럼명_제약 조건 유형 순으로 정한다.
    pk		primary key
    fk		foreign key
    nn		not null
    uk    	unique
    ck		check

    제약조건 이름 변경
    alter table table_name RENAME CONSTRAINTS 
    old_constraint_name TO new_constraint_name;
    
    제약 조건 삭제하기	
    alter table test drop constraint test1_name_pk;
   
    create table test1 (
	id number( 3 ) primary key, 
	name varchar2( 10 ) not null,
	tel varchar2( 10 ),
	address varchar2( 50 )
    );

▷ not null 제한 조건
    name varchar2(10) constraint test1_name_nn not null,
	
    기존 테이블의 컬럼을 not null 로 변경할 경우는 
    alter table ~ add constraint ~을 사용할 수 없다.
    not null 조건은 추가하는 것이 아니라 null 인 상태를 not null 로 바꾸는 것이다.

    alter table test1 modify name constraint test1_name_nn not null;

▷ 기본키 제약 조건
    기본 키 컬럼에는 NULL 값이 올 수 없으며 중복 될 수 없다.   

    id varchar2(10) constraint test1_id_pk primary key,	

    alter table test1 add constraint test1_id_pk primary key(id);
    alter table test1 drop constraint test1_id_pk;

▷ 유일키 제약조건
    UNIQUE 제약 조건을 지정하면 중복 값을 허용하지 않는다. 
    하나의 테이블에 여러 개를 지정할 수 있다.
    단 NULL은 값이 아니기 때문에 여러 개가 가능하다.

    name varchar2(10) constraint test2_name_uk unique,

    alter table test1 add constraint test1_email_uk unique(email);
    alter table test1 drop constraint test1_email_uk;

▷ check 제한 조건
    데이터를 검사하여 특정 조건에 맞는 데이터만 입력하도록 설정 한다.

    age number constraint test1_age_ck check( age between 0 and 150 ),

    alter table test1 add constraint test1_sal_ck check( sal between 0 and 20000 );
    alter table test1 drop constraint test1_sal_ck;

▷ 참조무결성
    create table depart (
	deno number primary key,
	dename varchar2( 30 ) unique
    );

    부서 테이블에 부서번호가 10 20 30 40이 존재한다면
    사원 테이블에 존재하는 부서번호는 반드시 부서 테이블의 부서 번호 내의 번호가 가져야 한다.
    이런 경우 사원 테이블이 부서 테이블을 참조하는 종속관계가 성립된다.
    사원 테이블은 자식 테이블이 되고 부서 테이블은 부모 테이블이 된다.

    사원 테이블의 부서번호 컬럼은 외래키라 하고 부서 테이블의 부서번호 컬럼이 부모키가 된다.
    부서번호 컬럼이 부모키가 되려면 UNIQUE 제약 조건으로 지정되어야 한다.

    새로 입력되는 사원정보중 부서번호가 부모키에 존재하지 않는 번호라면 
    무결성 제약 조건에 위배된다는 에러가 발생한다.

    create table test2(
	...
	deno varchar2(10) references depart( deno ),
	...
    );
    test1 테이블의 deno 컬럼을 참조하는 외래키를 설정한다.
    제약 조건명을 붙이지 않을 경우 오라클 서버 제약조건명을 붙인다.

    deno varchar2(10) constraint test2_deno_fk references depart( deno ),
    제약 조건명을 직접 붙여준다.

    alter table test2 add constraint test2_deno_fk foreign key(deno) references depart( deno );

▷ cascade
    참조 무결성 제약조건 탓에 기본키를 가진 테이블이 삭제되지 않는 경우는 
    맨 뒤에 cascade 옵션을 지정한다.

    drop table depart cascade constraint;

    select * from user_constraints where table_name = 'DBTEST';
    부모키를 가진 테이블이 삭제되면 제약조건도 삭제된다.