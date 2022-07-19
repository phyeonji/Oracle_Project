
-- TABLESPACE 생성
CREATE TABLESPACE TBS_TEAM2                   -- 생성하겠다. 테이블스페이스를... TBS_EDUA 라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_TEAM2.DBF'          -- 물리적 데이터 파일 경로 및 이름 지정
SIZE 4M                                       -- 사이즈(데이터 파일의 용량)
EXTENT MANAGEMENT LOCAL                       -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;                -- 세그먼트 공간 관리도 오라클서버가 자동으로 관리
--==>> TABLESPACE TBS_TEAM2이(가) 생성되었습니다.


--○ 생성된 테이블스페이스 조회
SELECT *
FROM DBA_TABLESPACES;

--○ 오라클 사용자 계정 생성
CREATE USER team2 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM2;
--==>> User TEAM2이(가) 생성되었습니다.

--C:\OracleStudy\OracleProject 폴더 생성


--○ 생성된 오라클 사용자 계정에
--   오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO team2;
--==>> Grant을(를) 성공했습니다.


--○ 각자 생성한 오라클 사용자 계정의 시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
--==>> TEAM2	CREATE SESSION	NO


--○ 각자 생성한 오라클사용자 계정에
--   테이블 생성이 가능하도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO TEAM2;
--==>> Grant을(를) 성공했습니다.


--○ 각자 생성한 오라클 사용자 계정에
--   테이블 스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량:QUOTA) 지정.
ALTER USER TEAM2 
QUOTA UNLIMITED ON TBS_TEAM2;
--==>> User TEAM2이(가) 변경되었습니다.



GRANT CREATE VIEW TO team2;

GRANT CREATE PROCEDURE TO team2;


GRANT CREATE TRIGGER TO team2;

