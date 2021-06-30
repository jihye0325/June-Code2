----------------------------------- �ǽ� ���� -----------------------------------
-- 1. �̸��� '��'�ڰ� ���� ������ ��� ��ȣ, �����, ���޸��� ��ȸ
-- ANSI
SELECT
       EMP_ID "��� ��ȣ"
     , EMP_NAME "�����"
     , DEPT_TITLE "���޸�"
    FROM  (SELECT 
                  EMP_ID
                , EMP_NAME
                , DEPT_TITLE
                FROM EMPLOYEE
                JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID))
    WHERE EMP_NAME LIKE '%��%';

-- ORACLE
SELECT
       EMP_ID "��� ��ȣ"
     , EMP_NAME "�����"
     , DEPT_TITLE "���޸�"
    FROM  (SELECT 
                  EMP_ID
                , EMP_NAME
                , DEPT_TITLE
                FROM EMPLOYEE, DEPARTMENT
            WHERE DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME LIKE '%��%';

-- 2. ���ʽ��� ���� �ʴ� J4, J7�� �����ڵ带 ���� ������ ������, ���޸�, ���� ��ȸ
-- ANSI
SELECT
       EMP_NAME ������
     , JOB_NAME ���޸�
     , SALARY ����
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
 WHERE BONUS IS NULL 
    AND JOB_CODE IN('J4', 'J7');
    
-- ORACLE
SELECT
       EMP_NAME ������
     , JOB_NAME ���޸�
     , SALARY ����
    FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
    AND BONUS IS NULL
    AND E.JOB_CODE IN('J4', 'J7');
    
-- 3. ���� '��'���� 70���� ���� ������ ������, �ֹε�Ϲ�ȣ, �μ���, ���޸��� ��ȸ
-- ANSI
SELECT 
       EMP_NAME ������
     , EMP_NO �ֹε�Ϲ�ȣ
     , DEPT_TITLE �μ���
     , JOB_NAME ���޸�
     FROM EMPLOYEE 
     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
 WHERE EMP_NAME LIKE '��%'
    AND EMP_NO LIKE '7%'
    AND SUBSTR(EMP_NO, 8,1) = 2;
    
-- ORACLE
SELECT 
       EMP_NAME ������
     , EMP_NO �ֹε�Ϲ�ȣ
     , DEPT_TITLE �μ���
     , JOB_NAME ���޸�
     FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE DEPT_CODE = DEPT_ID 
        AND E.JOB_CODE = J.JOB_CODE
        AND EMP_NAME LIKE '��%'
        AND EMP_NO LIKE '7%'
        AND SUBSTR(EMP_NO, 8,1) = 2;
-- 4. �μ��ڵ尡 D5, D6�� ����� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ
-- ANSI
SELECT
       EMP_NAME �����
     , JOB_NAME ���޸�
     , DEPT_CODE �μ��ڵ�
     , DEPT_TITLE �μ���
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_CODE IN('D5', 'D6');
 
-- ORACLE
SELECT
       EMP_NAME �����
     , JOB_NAME ���޸�
     , DEPT_CODE �μ��ڵ�
     , DEPT_TITLE �μ���
    FROM EMPLOYEE E, JOB J, DEPARTMENT
 WHERE E.JOB_CODE = J.JOB_CODE
    AND DEPT_CODE = DEPT_ID
    AND DEPT_CODE IN('D5', 'D6');

-- 5. ���ʽ��� �޴� ������ �����, ���ʽ�, �μ���, �������� ��ȸ
-- ANSI
SELECT
       EMP_NAME �����
     , BONUS ���ʽ�
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE BONUS IS NOT NULL;
 
-- ORACLE
SELECT
       EMP_NAME �����
     , BONUS ���ʽ�
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
    FROM EMPLOYEE, DEPARTMENT, LOCATION
 WHERE DEPT_CODE = DEPT_ID(+)
    AND LOCATION_ID = LOCAL_CODE(+)
    AND BONUS IS NOT NULL;
    
-- 6. SALARY ���̺��� MIN_SAL ������ �ʰ��� ������ �޴� ����� �����, ���޸�, ����, ����(���ʽ� ����) ��ȸ
-- ANSI
SELECT
       EMP_NAME �����
     , DEPT_TITLE ���޸�
     , SALARY ����
     , SALARY * (1 + NVL(BONUS, 0)) * 12 "����(���ʽ� ����)"
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN SAL_GRADE USING(SAL_LEVEL)
 WHERE SALARY > MIN_SAL;
                    
-- ORACLE
SELECT
       EMP_NAME �����
     , DEPT_TITLE ���޸�
     , SALARY ����
     , SALARY * (1 + NVL(BONUS, 0)) * 12 "����(���ʽ� ����)"
    FROM EMPLOYEE E, DEPARTMENT, SAL_GRADE S
 WHERE DEPT_CODE = DEPT_ID(+)
    AND E.SAL_LEVEL = S.SAL_LEVEL
    AND SALARY > MIN_SAL;
    
-- 7. �ѱ��� �Ϻ����� ���ϴ� �������� ������, �μ���, ������, ������ ��ȸ
-- ANSI
SELECT
       EMP_NAME ������
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
     , NATIONAL_NAME ������
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('�ѱ�', '�Ϻ�');

-- ORACLE
SELECT
       EMP_NAME ������
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
     , NATIONAL_NAME ������
    FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
 WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND NATIONAL_NAME IN('�ѱ�', '�Ϻ�');

-- 8. ������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸�, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�ϼ���
-- ANSI
SELECT
       EMP_ID ���
     , EMP_NAME �̸�
     , JOB_NAME ���޸�
     , DEPT_TITLE �μ���
     , LOCAL_NAME �ٹ�������
     , SALARY �޿�
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE JOB_NAME = '�븮'
    AND LOCAL_CODE IN('L1', 'L2', 'L3');
    
-- ORACLE
SELECT
       EMP_ID ���
     , EMP_NAME �̸�
     , JOB_NAME ���޸�
     , DEPT_TITLE �μ���
     , LOCAL_NAME �ٹ�������
     , SALARY �޿�
    FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
 WHERE E.JOB_CODE = J.JOB_CODE
    AND DEPT_CODE =DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND JOB_NAME = '�븮'
    AND LOCAL_CODE IN('L1', 'L2', 'L3');
    
-- 9. ��� ������ �����, ���޸�, �μ���, ������ ��ȸ (23��)
-- ANSI
SELECT
       EMP_NAME �����
     , JOB_NAME ���޸�
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
    FROM EMPLOYEE
    LEFT JOIN JOB USING(JOB_CODE)
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT
       EMP_NAME �����
     , JOB_NAME ���޸�
     , DEPT_TITLE �μ���
     , LOCAL_NAME ������
    FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
 WHERE E.JOB_CODE = J.JOB_CODE(+)
    AND DEPT_CODE = DEPT_ID(+)
    AND LOCATION_ID = LOCAL_CODE(+);

-- 10. EMPLOYEE ���̺��� MANAGER_ID�� �������� �ʴ��� ����� ���� �ǵ��� �Ͽ�
-- ������, ����̸�, �����ڻ��, �������̸� ��ȸ
-- ANSI
SELECT
       E.EMP_ID ������
     , E.EMP_NAME ����̸�
     , E.MANAGER_ID �����ڻ��
     , M.EMP_NAME �������̸�
    FROM EMPLOYEE E
    LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-- ORACLE
SELECT
       E.EMP_ID ������
     , E.EMP_NAME ����̸�
     , E.MANAGER_ID �����ڻ��
     , M.EMP_NAME �������̸�
    FROM EMPLOYEE E, EMPLOYEE M
 WHERE E.MANAGER_ID = M.EMP_ID(+);

