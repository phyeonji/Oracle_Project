
-- TABLESPACE ����
CREATE TABLESPACE TBS_TEAM2                   -- �����ϰڴ�. ���̺����̽���... TBS_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_TEAM2.DBF'          -- ������ ������ ���� ��� �� �̸� ����
SIZE 4M                                       -- ������(������ ������ �뷮)
EXTENT MANAGEMENT LOCAL                       -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;                -- ���׸�Ʈ ���� ������ ����Ŭ������ �ڵ����� ����
--==>> TABLESPACE TBS_TEAM2��(��) �����Ǿ����ϴ�.


--�� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES;

--�� ����Ŭ ����� ���� ����
CREATE USER team2 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM2;
--==>> User TEAM2��(��) �����Ǿ����ϴ�.

--C:\OracleStudy\OracleProject ���� ����


--�� ������ ����Ŭ ����� ������
--   ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO team2;
--==>> Grant��(��) �����߽��ϴ�.


--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
--==>> TEAM2	CREATE SESSION	NO


--�� ���� ������ ����Ŭ����� ������
--   ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO TEAM2;
--==>> Grant��(��) �����߽��ϴ�.


--�� ���� ������ ����Ŭ ����� ������
--   ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮:QUOTA) ����.
ALTER USER TEAM2 
QUOTA UNLIMITED ON TBS_TEAM2;
--==>> User TEAM2��(��) ����Ǿ����ϴ�.



GRANT CREATE VIEW TO team2;

GRANT CREATE PROCEDURE TO team2;


GRANT CREATE TRIGGER TO team2;

