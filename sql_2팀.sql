SELECT USER
FROM DUAL;


 -- [������] => �������� ���======================================================
 
SELECT P.PROFESSOR_NAME "������", SJ.SUBJECT_NAME "������ ����", SO.SOP_START "������۳�¥"
        , SO.SOP_END "�������ᳯ¥", BK.BOOK_NAME "�����", RM.ROOM_NAME "���ǽ�"
        , CASE WHEN (SO.SOP_END < SYSDATE) THEN '���� ����'
               WHEN (SO.SOP_START < SYSDATE) AND (SO.SOP_END > SYSDATE) THEN '���� ��'
               WHEN (SO.SOP_START > SYSDATE) AND (SO.SOP_END > SYSDATE) THEN '���� ����'
               ELSE '����'
               END "�������࿩��"
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


-- [������] => ���� ��� , ���� ���
-- ������, ���ǽ�, �����, ������۳�¥, �������ᳯ¥, �����, ������
SELECT CR.COURSE_NAME "������", RM.ROOM_CODE "���ǽ�", SJ.SUBJECT_NAME "�����"
     , SO.SOP_START "������۳�¥" , SO.SOP_END "�������ᳯ¥", BK.BOOK_NAME "�����"
     , P.PROFESSOR_NAME "������"
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
        
        
        
-- [������] => �л� ���� ���
-- �л� �̸�, ������, ��������, �������� ����
SELECT STUDENT_NAME "�̸�", CR.COURSE_NAME "������", SJ.SUBJECT_NAME "��������"
     , GA.GRADE_SILGI + GA.GRADE_PILGI + GA.GRADE_CHUL "������������"
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
        
        
-- [������] => ���� ���
-- �����, ������۳�¥, �������ᳯ¥, �����, �л���, ���, �Ǳ�, �ʱ�, ����, ���

SELECT SJ.SUBJECT_NAME "�����", SO.SOP_START "������۳�¥", SO.SOP_END "�������ᳯ¥"
     , BK.BOOK_NAME "�����", SD.STUDENT_NAME "�л���", GA.GRADE_CHUL "���"
     , GA.GRADE_SILGI "�Ǳ�", GA.GRADE_PILGI "�ʱ�"
     , GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI "����"
     , RANK() OVER(ORDER BY GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI) "���"
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


-- [�л�] => ���� ���
-- �л���, ������, �����, ������۳�¥, �������ᳯ¥, �����, ���, �Ǳ�, �ʱ�, ����, ���

SELECT SD.STUDENT_NAME "�л���", CR.COURSE_NAME "������", SJ.SUBJECT_NAME "�����" 
     , SO.SOP_START "������۳�¥", SO.SOP_END "�������ᳯ¥"
     , BK.BOOK_NAME "�����",  GA.GRADE_CHUL "���"
     , GA.GRADE_SILGI "�Ǳ�", GA.GRADE_PILGI "�ʱ�"
     , GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI "����"
     , RANK() OVER(ORDER BY GA.GRADE_CHUL + GA.GRADE_PILGI + GA.GRADE_SILGI) "���"
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
 

--<������ �ۼ� ���� update>

-- ���� ��¥ UPDATE
UPDATE TBL_SOPEN
SET SOP_START = ���۳�¥, SOP_END = ����¥
WHERE SOP_CODE = ���񰳼��ڵ�;

-- ���� �������� UPDATE
UPDATE TBL_SOPEN
SET PROFESSOR_ID = �ٲܴ�米��ID
WHERE SOP_CODE = ���񰳼��ڵ�;

-- ���� ���� UPDATE
UPDATE TBL_SOPEN
SET SOP_SILGI = �Ǳ����, SOP_PILGI = �ʱ����, SOP_CHUL = ������
WHERE SOP_CODE = ���񰳼��ڵ�;

-- ���� ����� ����
UPDATE TBL_SUBJECT
SET SUBJECT_NAME = �ٲܰ����
WHERE SUBJECT_CODE = �����ڵ�;

-- ���� ���纯��
UPDATE TBL_BOOK
SET BOOK_NAME = �ٲܱ����
WHERE BOOK_CODE = �����ڵ�;



-- ���� ���� (������)
-- ���� ��¥ UPDATE
UPDATE TBL_COPEN
SET COP_START = ���۳�¥, COP_END = ����¥
WHERE COP_CODE = ���������ڵ�;

UPDATE TBL_COURSE
SET COURSE_NAME = �ٲܰ�����
WHERE COURSE_CODE = �����ڵ�;


UPDATE TBL_ROOM
SET ROOM_NAME = �ٲܰ��ǽǸ�
WHERE ROOM_CODE = ���ǽ��ڵ�;


-- ���� ���� �ο� (����)
UPDATE TBL_SOPEN
SET SOP_SILGI = �ٲܽǱ����, SOP_PILGI = �ٲ��ʱ����, SOP_CHUL = �ٲ�������
WHERE SOP_CODE = �ٲܰ����ڵ�;


--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;
 
 
-- ���ν��� �׽�Ʈ
-- �α���--
SELECT *
FROM TBL_REGIST;

SELECT *
FROM TBL_GRADE;


 
        
        