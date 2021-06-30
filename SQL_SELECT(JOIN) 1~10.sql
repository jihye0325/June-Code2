----------------------------------- 실습 문제 -----------------------------------
-- 1. 이름에 '형'자가 들어가는 직원의 사원 번호, 사원명, 직급명을 조회
-- ANSI
SELECT
       EMP_ID "사원 번호"
     , EMP_NAME "사원명"
     , DEPT_TITLE "직급명"
    FROM  (SELECT 
                  EMP_ID
                , EMP_NAME
                , DEPT_TITLE
                FROM EMPLOYEE
                JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID))
    WHERE EMP_NAME LIKE '%형%';

-- ORACLE
SELECT
       EMP_ID "사원 번호"
     , EMP_NAME "사원명"
     , DEPT_TITLE "직급명"
    FROM  (SELECT 
                  EMP_ID
                , EMP_NAME
                , DEPT_TITLE
                FROM EMPLOYEE, DEPARTMENT
            WHERE DEPT_CODE = DEPT_ID)
    WHERE EMP_NAME LIKE '%형%';

-- 2. 보너스를 받지 않는 J4, J7의 직급코드를 가진 직원의 직원명, 직급명, 월급 조회
-- ANSI
SELECT
       EMP_NAME 직원명
     , JOB_NAME 직급명
     , SALARY 월급
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
 WHERE BONUS IS NULL 
    AND JOB_CODE IN('J4', 'J7');
    
-- ORACLE
SELECT
       EMP_NAME 직원명
     , JOB_NAME 직급명
     , SALARY 월급
    FROM EMPLOYEE E, JOB J
 WHERE E.JOB_CODE = J.JOB_CODE
    AND BONUS IS NULL
    AND E.JOB_CODE IN('J4', 'J7');
    
-- 3. 성이 '전'씨인 70년대생 여자 직원의 직원명, 주민등록번호, 부서명, 직급명을 조회
-- ANSI
SELECT 
       EMP_NAME 직원명
     , EMP_NO 주민등록번호
     , DEPT_TITLE 부서명
     , JOB_NAME 직급명
     FROM EMPLOYEE 
     JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
     JOIN JOB USING(JOB_CODE)
 WHERE EMP_NAME LIKE '전%'
    AND EMP_NO LIKE '7%'
    AND SUBSTR(EMP_NO, 8,1) = 2;
    
-- ORACLE
SELECT 
       EMP_NAME 직원명
     , EMP_NO 주민등록번호
     , DEPT_TITLE 부서명
     , JOB_NAME 직급명
     FROM EMPLOYEE E, DEPARTMENT D, JOB J
    WHERE DEPT_CODE = DEPT_ID 
        AND E.JOB_CODE = J.JOB_CODE
        AND EMP_NAME LIKE '전%'
        AND EMP_NO LIKE '7%'
        AND SUBSTR(EMP_NO, 8,1) = 2;
-- 4. 부서코드가 D5, D6인 사원의 사원명, 직급명, 부서코드, 부서명을 조회
-- ANSI
SELECT
       EMP_NAME 사원명
     , JOB_NAME 직급명
     , DEPT_CODE 부서코드
     , DEPT_TITLE 부서명
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE DEPT_CODE IN('D5', 'D6');
 
-- ORACLE
SELECT
       EMP_NAME 사원명
     , JOB_NAME 직급명
     , DEPT_CODE 부서코드
     , DEPT_TITLE 부서명
    FROM EMPLOYEE E, JOB J, DEPARTMENT
 WHERE E.JOB_CODE = J.JOB_CODE
    AND DEPT_CODE = DEPT_ID
    AND DEPT_CODE IN('D5', 'D6');

-- 5. 보너스를 받는 직원의 사원명, 보너스, 부서명, 지역명을 조회
-- ANSI
SELECT
       EMP_NAME 사원명
     , BONUS 보너스
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE BONUS IS NOT NULL;
 
-- ORACLE
SELECT
       EMP_NAME 사원명
     , BONUS 보너스
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
    FROM EMPLOYEE, DEPARTMENT, LOCATION
 WHERE DEPT_CODE = DEPT_ID(+)
    AND LOCATION_ID = LOCAL_CODE(+)
    AND BONUS IS NOT NULL;
    
-- 6. SALARY 테이블의 MIN_SAL 기준을 초과한 월급을 받는 사원의 사원명, 직급명, 월급, 연봉(보너스 포함) 조회
-- ANSI
SELECT
       EMP_NAME 사원명
     , DEPT_TITLE 직급명
     , SALARY 월급
     , SALARY * (1 + NVL(BONUS, 0)) * 12 "연봉(보너스 포함)"
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN SAL_GRADE USING(SAL_LEVEL)
 WHERE SALARY > MIN_SAL;
                    
-- ORACLE
SELECT
       EMP_NAME 사원명
     , DEPT_TITLE 직급명
     , SALARY 월급
     , SALARY * (1 + NVL(BONUS, 0)) * 12 "연봉(보너스 포함)"
    FROM EMPLOYEE E, DEPARTMENT, SAL_GRADE S
 WHERE DEPT_CODE = DEPT_ID(+)
    AND E.SAL_LEVEL = S.SAL_LEVEL
    AND SALARY > MIN_SAL;
    
-- 7. 한국과 일본에서 일하는 직원들의 직원명, 부서명, 지역명, 국가명 조회
-- ANSI
SELECT
       EMP_NAME 직원명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
     , NATIONAL_NAME 국가명
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국', '일본');

-- ORACLE
SELECT
       EMP_NAME 직원명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
     , NATIONAL_NAME 국가명
    FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
 WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND NATIONAL_NAME IN('한국', '일본');

-- 8. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- ANSI
SELECT
       EMP_ID 사번
     , EMP_NAME 이름
     , JOB_NAME 직급명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 근무지역명
     , SALARY 급여
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE JOB_NAME = '대리'
    AND LOCAL_CODE IN('L1', 'L2', 'L3');
    
-- ORACLE
SELECT
       EMP_ID 사번
     , EMP_NAME 이름
     , JOB_NAME 직급명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 근무지역명
     , SALARY 급여
    FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
 WHERE E.JOB_CODE = J.JOB_CODE
    AND DEPT_CODE =DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND JOB_NAME = '대리'
    AND LOCAL_CODE IN('L1', 'L2', 'L3');
    
-- 9. 모든 직원의 사원명, 직급명, 부서명, 지역명 조회 (23명)
-- ANSI
SELECT
       EMP_NAME 사원명
     , JOB_NAME 직급명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
    FROM EMPLOYEE
    LEFT JOIN JOB USING(JOB_CODE)
    LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- ORACLE
SELECT
       EMP_NAME 사원명
     , JOB_NAME 직급명
     , DEPT_TITLE 부서명
     , LOCAL_NAME 지역명
    FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
 WHERE E.JOB_CODE = J.JOB_CODE(+)
    AND DEPT_CODE = DEPT_ID(+)
    AND LOCATION_ID = LOCAL_CODE(+);

-- 10. EMPLOYEE 테이블에서 MANAGER_ID가 존재하지 않더라도 결과에 포함 되도록 하여
-- 사원사번, 사원이름, 관리자사번, 관리자이름 조회
-- ANSI
SELECT
       E.EMP_ID 사원사번
     , E.EMP_NAME 사원이름
     , E.MANAGER_ID 관리자사번
     , M.EMP_NAME 관리자이름
    FROM EMPLOYEE E
    LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-- ORACLE
SELECT
       E.EMP_ID 사원사번
     , E.EMP_NAME 사원이름
     , E.MANAGER_ID 관리자사번
     , M.EMP_NAME 관리자이름
    FROM EMPLOYEE E, EMPLOYEE M
 WHERE E.MANAGER_ID = M.EMP_ID(+);

