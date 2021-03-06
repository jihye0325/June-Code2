-- 1.
SELECT
       STUDENT_NO 학번
     , STUDENT_NAME 이름
     , TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
    FROM TB_STUDENT
 WHERE DEPARTMENT_NO = 002
  ORDER BY ENTRANCE_DATE;
  
-- 2.
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
-- 10. 
SELECT
       DEPARTMENT_NO
     , COUNT(*)
    FROM TB_STUDENT
    GROUP BY DEPARTMENT_NO
    ORDER BY 1;

-- 11.
SELECT
       COUNT(*)
    FROM TB_STUDENT
 WHERE COACH_PROFESSOR_NO IS NULL;

-- 12.
SELECT
       SUBSTR(TERM_NO, 1, 4) 년도
     , ROUND(AVG(POINT), 1) "년도 별 평점"
    FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY SUBSTR(TERM_NO, 1, 4)
 ORDER BY 1;

-- 13.
SELECT
       DEPARTMENT_NO "학과코드명"
     , COUNT(DECODE(ABSENCE_YN, 'Y', 1, 'N', NULL)) "휴학생 수"
    FROM TB_STUDENT
 GROUP BY DEPARTMENT_NO
 ORDER BY 1;

-- 14.
SELECT
       STUDENT_NAME "동일이름"
     , COUNT(STUDENT_NAME) "동명인 수"
    FROM TB_STUDENT
 GROUP BY STUDENT_NAME
 HAVING COUNT(STUDENT_NAME) >= 2
 ORDER BY 1;

-- 15. 
SELECT
       SUBSTR(TERM_NO, 1, 4) 년도
     , SUBSTR(TERM_NO, 5, 2) 학기
     , ROUND(AVG(POINT), 1) 평점
    FROM TB_GRADE
 WHERE STUDENT_NO = 'A112113'
 GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
 ORDER BY 1, 2;






