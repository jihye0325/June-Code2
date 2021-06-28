-- 1.
SELECT
       STUDENT_NO 학번
     , STUDENT_NAME 이름
     , TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
    FROM TB_STUDENT
 WHERE DEPARTMENT_NO = 002
  ORDER BY ENTRANCE_DATE;
  
-- 2. 이유 :
SELECT 
       PROFESSOR_NAME
     , PROFESSOR_SSN
    FROM TB_PROFESSOR
 WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 3.
SELECT
       PROFESSOR_NAME 교수이름
     , TO_CHAR(SYSDATE, 'YYYY') - (TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'YY-MM-DD') , 'YYYY') - 100) "나이"
    FROM TB_PROFESSOR
 WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
  ORDER BY 나이;
 
-- 4.
SELECT
       SUBSTR(PROFESSOR_NAME, 2, LENGTH(PROFESSOR_NAME)-1)  이름
    FROM TB_PROFESSOR;
    
-- 5.
SELECT
       STUDENT_NO
     , STUDENT_NAME
    FROM TB_STUDENT
 WHERE TO_CHAR(ENTRANCE_DATE, 'RRRR') - TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RR-MM-DD'), 'RRRR') > 19;

-- 6.
SELECT 
       TO_CHAR(TO_DATE('2020-12-25', 'YYYY-MM-DD'), 'DAY')
    FROM DUAL;
    
-- 7.
SELECT
       TO_DATE('99/10/11', 'YY/MM/DD') "2099년 10월 11일"
     , TO_DATE('49/10/11', 'YY/MM/DD') "2049년 10월 11일"
     , TO_DATE('99/10/11', 'RR/MM/DD') "1999년 10월 11일"
     , TO_DATE('49/10/11', 'RR/MM/DD') "2049년 10월 11일"
    FROM DUAL;

-- 8.
SELECT
       STUDENT_NO
     , STUDENT_NAME
    FROM TB_STUDENT
 WHERE SUBSTR(STUDENT_NO, 1, 1) != 'A';

-- 9.
SELECT
      LPAD(ROUND(AVG(POINT), 1), 10) 평점
    FROM TB_GRADE
 WHERE STUDENT_NO = 'A517178';









