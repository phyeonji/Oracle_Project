SELECT USER
FROM DUAL;


 -- [관리자] => 교수정보 출력======================================================
 
SELECT P.PROFESSOR_NAME "교수명", SJ.SUBJECT_NAME "배정된 과목", SO.SOP_START "과목시작날짜"
        , SO.SOP_END "과목종료날짜", BK.BOOK_NAME "교재명", RM.ROOM_NAME "강의실"
        , CASE WHEN (SO.SOP_END < SYSDATE) THEN '강의 종료'
               WHEN (SO.SOP_START < SYSDATE) AND (SO.SOP_END > SYSDATE) THEN '강의 중'
               WHEN (SO.SOP_START > SYSDATE) AND (SO.SOP_END > SYSDATE) THEN '강의 예정'
               ELSE '오류'
               END "강의진행여부"
FROM TBL_PRO P JOIN TBL_SOPEN SO
ON SO.PROFESSOR_ID = P.PROFESSOR_ID
        JOIN TBL_SUBJECT SJ
        ON SO.SUBJECT_CODE = SJ.SUBJECT_CODE 
        JOIN TBL_BOOK BK
        ON SO.BOOK_CODE = BK.BOOK_CODE
        JOIN TBL_COPEN CO
        ON SO.COP_CODE = CO.COP_CODE
        JOIN TBL_ROOM RM
        ON CO.ROOM_CODE = RM.ROOM_CODE;
        

--INSERT INTO TBL_GRADE(GRADE_CODE, GRADE_SILGI, GRADE_PILGI, GRADE_CHUL, REGIST_CODE, SOP_CODE, GRADE_DATE)
--VALUES('GRADE002', 60, 50, 90, 'REGIST01', 'SOP01', '2022-02-28');


-- [관리자] => 과정 출력 , 과목 출력
-- 과정명, 강의실, 과목명, 과목시작날짜, 과목종료날짜, 교재명, 교수명
SELECT CR.COURSE_NAME "과정명", RM.ROOM_CODE "강의실", SJ.SUBJECT_NAME "과목명"
     , SO.SOP_START "과목시작날짜" , SO.SOP_END "과목종료날짜", BK.BOOK_NAME "교재명"
     , P.PROFESSOR_NAME "교수명"
FROM TBL_COPEN CO 
        JOIN TBL_COURSE CR
        ON CO.COURSE_CODE = CR.COURSE_CODE
        JOIN TBL_ROOM RM
        ON CO.ROOM_CODE = RM.ROOM_CODE
        JOIN TBL_SOPEN SO
        ON CO.COP_CODE = SO.COP_CODE
        JOIN TBL_SUBJECT SJ
        ON SO.SUBJECT_CODE = SJ.SUBJECT_CODE
        JOIN TBL_BOOK BK
        ON SO.BOOK_CODE = BK.BOOK_CODE
        JOIN TBL_PRO P
        ON SO.PROFESSOR_ID = P.PROFESSOR_ID;
        
        
        
-- [관리자] => 학생 정보 출력
-- 학생 이름, 과정명, 수강과목, 수강과목 총점
SELECT STUDENT_NAME "이름", CR.COURSE_NAME "과정명", SJ.SUBJECT_NAME "수강과목"
     , GA.GRADE_SILGI + GA.GRADE_PILGI + GA.GRADE_CHUL "수강과목총점"
FROM TBL_STUDENT SD
        JOIN TBL_REGIST RG
        ON RG.STUDENT_ID = SD.STUDENT_ID
        JOIN TBL_COPEN CO
        ON CO.COP_CODE = RG.COP_CODE
        JOIN TBL_COURSE CR
        ON CO.COURSE_CODE = CR.COURSE_CODE
        JOIN TBL_GRADE GA
        ON GA.REGIST_CODE = RG.REGIST_CODE
        JOIN TBL_SOPEN SO
        ON SO.SOP_CODE = GA.SOP_CODE
        JOIN TBL_SUBJECT SJ
        ON SJ.SUBJECT_CODE = SO.SUBJECT_CODE;
        
        
-- [교수자] => 성적 출력
-- 과목명, 과목시작날짜, 과목종료날짜, 교재명, 학생명, 출결, 실기, 필기, 총점, 등수

SELECT SJ.SUBJECT_NAME "과목명", SO.SOP_START "과목시작날짜", SO.SOP_END "과목종료날짜"
     , BK.BOOK_NAME "교재명", SD.STUDENT_NAME "학생명", GA.GRADE_CHUL "출결"
     , GA.GRADE_SILGI "실기", GA.GRADE_PILGI "필기"
     , GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI "총점"
     , RANK() OVER(ORDER BY GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI) "등수"
FROM TBL_SOPEN SO
        JOIN TBL_PRO P
        ON SO.PROFESSOR_ID = P.PROFESSOR_ID
        JOIN TBL_SUBJECT SJ
        ON SJ.SUBJECT_CODE = SO.SUBJECT_CODE
        JOIN TBL_BOOK BK
        ON SO.BOOK_CODE = BK.BOOK_CODE
        JOIN TBL_GRADE GA
        ON GA.SOP_CODE = SO.SOP_CODE
        JOIN TBL_REGIST RG
        ON RG.REGIST_CODE = GA.REGIST_CODE
        JOIN TBL_STUDENT SD
        ON SD.STUDENT_ID = RG.STUDENT_ID
WHERE P.PROFESSOR_ID = 'PRO001';


-- [학생] => 성적 출력
-- 학생명, 과정명, 과목명, 과목시작날짜, 과목종료날짜, 교재명, 출결, 실기, 필기, 총점, 등수

SELECT SD.STUDENT_NAME "학생명", CR.COURSE_NAME "과정명", SJ.SUBJECT_NAME "과목명" 
     , SO.SOP_START "과목시작날짜", SO.SOP_END "과목종료날짜"
     , BK.BOOK_NAME "교재명",  GA.GRADE_CHUL "출결"
     , GA.GRADE_SILGI "실기", GA.GRADE_PILGI "필기"
     , GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI "총점"
     , RANK() OVER(ORDER BY GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI) "등수"
FROM TBL_SOPEN SO
        JOIN TBL_PRO P
        ON SO.PROFESSOR_ID = P.PROFESSOR_ID
        JOIN TBL_SUBJECT SJ
        ON SJ.SUBJECT_CODE = SO.SUBJECT_CODE
        JOIN TBL_BOOK BK
        ON SO.BOOK_CODE = BK.BOOK_CODE
        JOIN TBL_GRADE GA
        ON GA.SOP_CODE = SO.SOP_CODE
        JOIN TBL_REGIST RG
        ON RG.REGIST_CODE = GA.REGIST_CODE
        JOIN TBL_STUDENT SD
        ON SD.STUDENT_ID = RG.STUDENT_ID
        JOIN TBL_COPEN CO
        ON SO.COP_CODE = CO.COP_CODE
        JOIN TBL_COURSE CR
        ON CR.COURSE_CODE = CO.COURSE_CODE
WHERE SD.STUDENT_ID = '20220001'
  AND SO.SOP_END < SYSDATE;
  -- AND SO.SOP_END < TO_DATE('2022-02-02', 'YYYY-MM-DD');
 

--<쿼리문 작성 과목 update>

-- 과목 날짜 UPDATE
UPDATE TBL_SOPEN
SET SOP_START = 시작날짜, SOP_END = 끝날짜
WHERE SOP_CODE = 과목개설코드;

-- 과목 배정교수 UPDATE
UPDATE TBL_SOPEN
SET PROFESSOR_ID = 바꿀담당교수ID
WHERE SOP_CODE = 과목개설코드;

-- 과목 배점 UPDATE
UPDATE TBL_SOPEN
SET SOP_SILGI = 실기배점, SOP_PILGI = 필기배점, SOP_CHUL = 출결배점
WHERE SOP_CODE = 과목개설코드;

-- 과목 과목명 변경
UPDATE TBL_SUBJECT
SET SUBJECT_NAME = 바꿀과목명
WHERE SUBJECT_CODE = 과목코드;

-- 과목 교재변경
UPDATE TBL_BOOK
SET BOOK_NAME = 바꿀교재명
WHERE BOOK_CODE = 교재코드;



-- 과정 수정 (관리자)
-- 과정 날짜 UPDATE
UPDATE TBL_COPEN
SET COP_START = 시작날짜, COP_END = 끝날짜
WHERE COP_CODE = 과정개설코드;

UPDATE TBL_COURSE
SET COURSE_NAME = 바꿀과정명
WHERE COURSE_CODE = 과정코드;


UPDATE TBL_ROOM
SET ROOM_NAME = 바꿀강의실명
WHERE ROOM_CODE = 강의실코드;


-- 과목 배점 부여 (교수)
UPDATE TBL_SOPEN
SET SOP_SILGI = 바꿀실기배점, SOP_PILGI = 바꿀필기배점, SOP_CHUL = 바꿀출결배점
WHERE SOP_CODE = 바꿀과목코드;


--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;
 
 
-- 프로시저 테스트
-- 로그인--
SELECT *
FROM TBL_REGIST;

SELECT *
FROM TBL_GRADE;


 
        
        