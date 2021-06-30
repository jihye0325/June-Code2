-- 1
SELECT
       STUDENT_NAME "�л� �̸�"
     , STUDENT_ADDRESS "�ּ���"
    FROM TB_STUDENT
 ORDER BY 1;

-- 2
SELECT
       STUDENT_NAME 
     , STUDENT_SSN
    FROM TB_STUDENT
 WHERE ABSENCE_YN = 'Y'
 ORDER BY 2 DESC;

-- 3
SELECT
       STUDENT_NAME "�л��̸�"
     , STUDENT_NO "�й�"
     , STUDENT_ADDRESS "������ �ּ�"
    FROM TB_STUDENT
 WHERE (STUDENT_ADDRESS LIKE '����%' OR STUDENT_ADDRESS LIKE '���%')
        AND STUDENT_NO LIKE '9%'
 ORDER BY 1;

-- 4
-- ANSI ǥ��
SELECT 
       PROFESSOR_NAME
     , PROFESSOR_SSN
    FROM TB_PROFESSOR
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    WHERE DEPARTMENT_NAME = '���а�'
    ORDER BY 2;
    
-- ����Ŭ ���� ����
SELECT 
       PROFESSOR_NAME
     , PROFESSOR_SSN
    FROM TB_PROFESSOR P, TB_DEPARTMENT D
 WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
        AND D.DEPARTMENT_NAME = '���а�'
 ORDER BY 2;
 
-- 5
SELECT
       STUDENT_NO
     , TO_CHAR(POINT, '9.99')
    FROM TB_GRADE
 WHERE TERM_NO = '200402' 
    AND CLASS_NO = 'C3118100'
 ORDER BY 2 DESC, 1;

-- 6
-- ANSI ǥ��
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , DEPARTMENT_NAME
    FROM TB_STUDENT 
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    ORDER BY 2;
    
-- ����Ŭ ���� ����
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , DEPARTMENT_NAME
    FROM TB_DEPARTMENT D, TB_STUDENT S
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
 ORDER BY 2;
 
-- 7
-- ANSI ǥ��
SELECT
       CLASS_NAME
     , DEPARTMENT_NAME
    FROM TB_CLASS
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

-- ORACLE ���� ����
SELECT 
       CLASS_NAME
     , DEPARTMENT_NAME
    FROM TB_CLASS C, TB_DEPARTMENT D
 WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;







