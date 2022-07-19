SELECT USER
FROM DUAL;
--==>> TEAM2


CREATE TABLE TBL_ORAUSERTEST
( NO   NUMBER(10)
, NAME VARCHAR2(30)
);
--==>> Table TBL_ORAUSERTEST��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_ORAUSERTEST;
--==>> ���̺� ���� �Ϸ�. �� ���̺�.

SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_TEAM2	65536	-1	8	-1	NO
-- -1�� ������ �̶�� �ǹ�.


DROP TABLE TBL_ADMIN;

--[���������̺� ����]===========================================================
CREATE TABLE TBL_ADMIN
( ADMIN_ID    VARCHAR2(20)                                                -- ������ID
, ADMIN_PW    VARCHAR2(20) CONSTRAINT ADMIN_ADMIN_PW_NN NOT NULL          -- ������PW
, CONSTRAINT ADMIN_ADMIN_ID_PK PRIMARY KEY(ADMIN_ID)                      
);
--==>> Table TBL_ADMIN��(��) �����Ǿ����ϴ�.
--==============================================================================



--[�������̺� ����]=============================================================
CREATE TABLE TBL_PRO
( PROFESSOR_ID    VARCHAR2(20)                                              --����ID
, PROFESSOR_PW    VARCHAR2(20) CONSTRAINT PRO_PROFESSOR_PW_NN NOT NULL      --���� PW
, PROFESSOR_NAME  VARCHAR2(20) CONSTRAINT PRO_PROFESSOR_NAME_NN NOT NULL    --�����̸�
, PROFESSOR_SSN   CHAR(7)      CONSTRAINT PRO_PROFESSOR_SSN_NN NOT NULL     --�����ֹι�ȣ���ڸ�
, PROFESSOR_JOIN  DATE         CONSTRAINT PRO_PROFESSOR_JOIN_NN NOT NULL    --����������
, CONSTRAINT PRO_PROFESSOR_ID_PK PRIMARY KEY(PROFESSOR_ID)
);
--==>> Table TBL_PRO��(��) �����Ǿ����ϴ�.

ALTER TABLE TBL_PRO
ADD CONSTRAINT PRO_PROFESSOR_SSN_UK UNIQUE (PROFESSOR_SSN);
--==>> Table TBL_PRO��(��) ����Ǿ����ϴ�.

--==============================================================================


--[�л����̺� ����]=============================================================
CREATE TABLE TBL_STUDENT
( STUDENT_ID   VARCHAR2(20)
, STUDENT_PW   VARCHAR2(20) CONSTRAINT STUDENT_STUDENT_PW_NN NOT NULL
, STUDENT_NAME VARCHAR2(30) CONSTRAINT STUDENT_STUDENT_NAME_NN NOT NULL
, STUDENT_SSN  CHAR(7)      CONSTRAINT STUDENT_STUDENT_SSN_NN NOT NULL
, STUDENT_JOIN DATE         CONSTRAINT STUDENT_STUDENT_JOIN_NN NOT NULL
, CONSTRAINT STUDENT_STUDENT_ID_PK PRIMARY KEY(STUDENT_ID)
);
--==>> Table TBL_STUDENT��(��) �����Ǿ����ϴ�.

ALTER TABLE TBL_STUDENT
ADD CONSTRAINT STUDENT_STUDENT_SSN_UK UNIQUE (STUDENT_SSN);
--==>> Table TBL_STUDENT��(��) ����Ǿ����ϴ�.

--==============================================================================



--[����Ż�� ���̺� ����]=========================================================
CREATE TABLE TBL_FAIL
( FAIL_CODE     VARCHAR2(20)
, REGIST_CODE   VARCHAR2(20)  CONSTRAINT FAIL_REGIST_CODE_NN NOT NULL
, FAIL_DATE     DATE          CONSTRAINT FAIL_FAIL_DATE_NN NOT NULL
, REASON_CODE   VARCHAR2(20)  CONSTRAINT FAIL_REASON_CODE_NN NOT NULL
, CONSTRAINT FAIL_FAIL_CODE_PK PRIMARY KEY(FAIL_CODE)
);
--==>> Table TBL_FAIL��(��) �����Ǿ����ϴ�.


ALTER TABLE TBL_FAIL
ADD ( CONSTRAINT FAIL_REGIST_CODE_FK FOREIGN KEY (REGIST_CODE)
                REFERENCES TBL_REGIST (REGIST_CODE)  
   , CONSTRAINT FAIL_REASON_CODE_FK FOREIGN KEY (REASON_CODE)
                REFERENCES TBL_REASON (REASON_CODE) );
--==>> Table TBL_FAIL��(��) ����Ǿ����ϴ�.
--==============================================================================





--[Ż������ ���̺� ����]========================================================
CREATE TABLE TBL_REASON
( REASON_CODE     VARCHAR2(20)
, REASON_DROPOUT  VARCHAR2(50)  CONSTRAINT REASON_REASON_DROPOUT_NN NOT NULL
, CONSTRAINT REASON_REASON_CODE_PK PRIMARY KEY (REASON_CODE)
);
--==>> Table TBL_REASON��(��) �����Ǿ����ϴ�.
--==============================================================================




--[���� ���̺� ����]============================================================
CREATE TABLE TBL_SUBJECT
( SUBJECT_CODE  VARCHAR2(20)
, SUBJECT_NAME  VARCHAR2(20) CONSTRAINT SUBJECT_SUBJECT_NAME_NN NOT NULL
, CONSTRAINT SUBJECT_SUBJECT_CODE_PK PRIMARY KEY (SUBJECT_CODE)
);
--==>> Table TBL_SUBJECT��(��) �����Ǿ����ϴ�.
--==============================================================================




--[���� ���̺� ����]============================================================
CREATE TABLE TBL_BOOK
( BOOK_CODE VARCHAR2(20)
, BOOK_NAME VARCHAR2(20) CONSTRAINT BOOK_BOOK_NAME_NN NOT NULL
, CONSTRAINT BOOK_BOOK_CODE_PK PRIMARY KEY (BOOK_CODE)
);
--==>> Table TBL_BOOK��(��) �����Ǿ����ϴ�.
--==============================================================================




--[���� ���̺� ����]============================================================
CREATE TABLE TBL_COURSE
( COURSE_CODE  VARCHAR2(20)
, COURSE_NAME  VARCHAR2(20) CONSTRAINT COURSE_COURSE_NAME_NN NOT NULL
, CONSTRAINT COURSE_COURSE_CODE_PK PRIMARY KEY (COURSE_CODE)
);
--==>> Table TBL_COURSE��(��) �����Ǿ����ϴ�.
--==============================================================================




--[���� ���̺� ����]============================================================
CREATE TABLE TBL_ROOM
( ROOM_CODE VARCHAR2(20)
, ROOM_NAME VARCHAR2(20) CONSTRAINT ROOM_ROOM_NAME_NN NOT NULL
, CONSTRAINT ROOM_ROOM_CODE_PK PRIMARY KEY(ROOM_CODE)
);
--==>> Table TBL_ROOM��(��) �����Ǿ����ϴ�.
--==============================================================================





--[�������� ���̺� ����]========================================================
CREATE TABLE TBL_COPEN
( COP_CODE      VARCHAR2(20)
, COURSE_CODE   VARCHAR2(20)
, COP_START     DATE  
, COP_END       DATE
, ROOM_CODE     VARCHAR2(20)
, COP_DATE      DATE         CONSTRAINT COPEN_COP_DATE_NN NOT NULL
, CONSTRAINT COPEN_COP_CODE_PK PRIMARY KEY(COP_CODE)
, CONSTRAINT COPEN_COP_DATE_INTERVAL_CK CHECK ( COP_START < COP_END )
);
--==>> Table TBL_COPEN��(��) �����Ǿ����ϴ�.


ALTER TABLE TBL_COPEN
ADD ( CONSTRAINT COPEN_COURSE_CODE_FK FOREIGN KEY (COURSE_CODE)
                REFERENCES TBL_COURSE (COURSE_CODE)
    , CONSTRAINT COPEN_ROOM_CODE_FK FOREIGN KEY (ROOM_CODE)
                REFERENCES TBL_ROOM (ROOM_CODE) );
--==>> Table TBL_COPEN��(��) ����Ǿ����ϴ�.
--==============================================================================




--[������û ���̺� ����]========================================================
CREATE TABLE TBL_REGIST
( REGIST_CODE VARCHAR2(20)
, STUDENT_ID   VARCHAR2(20)
, COP_CODE     VARCHAR2(20)
, REGIST_DATE  DATE  CONSTRAINT REGIST_REGIST_DATE_NN NOT NULL
, CONSTRAINT REGIST_REGIST_CODE_PK PRIMARY KEY(REGIST_CODE)
);
--==>> Table TBL_REGIST��(��) �����Ǿ����ϴ�.


ALTER TABLE TBL_REGIST
ADD ( CONSTRAINT REGIST_STUDENT_ID_FK FOREIGN KEY(STUDENT_ID)
                REFERENCES TBL_STUDENT (STUDENT_ID)
  , CONSTRAINT REGIST_COP_CODE_FK FOREIGN KEY(COP_CODE)
                REFERENCES TBL_COPEN (COP_CODE) );
--==>> Table TBL_REGIST��(��) ����Ǿ����ϴ�.
--==============================================================================



DROP TABLE TBL_GRADE;

--[���� ���̺� ����]============================================================
-- < ������ ���� CK �������� �����Բ� ���庸�� > 
CREATE TABLE TBL_GRADE
( GRADE_CODE   VARCHAR2(20)
, GRADE_SILGI  NUMBER
, GRADE_PILGI  NUMBER
, GRADE_CHUL   NUMBER
, REGIST_CODE  VARCHAR2(20)
, SOP_CODE     VARCHAR2(20)
, GRADE_DATE   DATE          CONSTRAINT GRADE_GRADE_DATE_NN NOT NULL
, CONSTRAINT GRADE_GRADE_CODE_PK PRIMARY KEY(GRADE_CODE)
);
--==>> Table TBL_GRADE��(��) �����Ǿ����ϴ�.


ALTER TABLE TBL_GRADE
ADD ( CONSTRAINT GRADE_REGIST_CODE_FK FOREIGN KEY (REGIST_CODE)
                REFERENCES TBL_REGIST (REGIST_CODE)
    , CONSTRAINT GRADE_SOP_CODE_FK FOREIGN KEY (SOP_CODE)
                REFERENCES TBL_SOPEN (SOP_CODE)
    , CONSTRAINT GRADE_GRADE_SILGI_CK CHECK (GRADE_SILGI BETWEEN 0 AND 100 )
    , CONSTRAINT GRADE_GRADE_PILGI_CK CHECK (GRADE_PILGI BETWEEN 0 AND 100)
    , CONSTRAINT GRADE_GRADE_CHUL_CK CHECK (GRADE_CHUL BETWEEN 0 AND 100) );
--==>> Table TBL_GRADE��(��) ����Ǿ����ϴ�.

--==============================================================================




--[���񰳼� ���̺� ����]========================================================
CREATE TABLE TBL_SOPEN
( SOP_CODE      VARCHAR2(20)
, SUBJECT_CODE  VARCHAR2(20)
, SOP_START     DATE
, SOP_END       DATE
, PROFESSOR_ID  VARCHAR2(20)
, COP_CODE      VARCHAR2(20)
, SOP_SILGI     NUMBER
, SOP_PILGI     NUMBER
, SOP_CHUL      NUMBER
, BOOK_CODE     VARCHAR2(20)
, SOP_DATE      DATE         CONSTRAINT SOPEN_SOP_DATE_NN NOT NULL
, CONSTRAINT SOPEN_SOP_CODE_PK PRIMARY KEY (SOP_CODE)
, CONSTRAINT SOPEN_SOP_DATE_INTERVAL_CK CHECK ( SOP_START < SOP_END )
, CONSTRAINT SOPEN_SCORE_SUM_CK CHECK (SOP_SILGI + SOP_PILGI + SOP_CHUL = 100)
);
--==>> Table TBL_SOPEN��(��) �����Ǿ����ϴ�.


ALTER TABLE TBL_SOPEN
ADD ( CONSTRAINT SOPEN_SUBJECT_CODE_FK FOREIGN KEY (SUBJECT_CODE)
                REFERENCES TBL_SUBJECT (SUBJECT_CODE)
    , CONSTRAINT SOPEN_PROFESSOR_ID_FK FOREIGN KEY (PROFESSOR_ID)
                REFERENCES TBL_PRO (PROFESSOR_ID)
    , CONSTRAINT SOPEN_COP_CODE_FK FOREIGN KEY (COP_CODE)
                REFERENCES TBL_COPEN (COP_CODE)
    , CONSTRAINT SOPEN_BOOK_CODE_FK FOREIGN KEY (BOOK_CODE)
                REFERENCES TBL_BOOK (BOOK_CODE) );
--==>> Table TBL_SOPEN��(��) ����Ǿ����ϴ�.
--==============================================================================

-- �������� Ȯ��
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_ADMIN';


SELECT *
FROM TAB;













































































































