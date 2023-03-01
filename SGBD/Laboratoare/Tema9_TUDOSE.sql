CREATE OR REPLACE PACKAGE PACHET1_REZ AS
    -- A)
    PROCEDURE P_ADAUG(NUME EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME EMPLOYEES.FIRST_NAME%TYPE,
                                        TELEFON EMPLOYEES.PHONE_NUMBER%TYPE,
                                        EMAIL EMPLOYEES.EMAIL%TYPE,
                                        NUME_JOB JOBS.JOB_TITLE%TYPE, 
                                        NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE,
                                        NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE);
    
    FUNCTION F_COD_JOB(NUME_JOB JOBS.JOB_TITLE%TYPE)
        RETURN EMPLOYEES.JOB_ID%TYPE;
    
    FUNCTION F_COD_MANAGER(NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                           PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE)
        RETURN EMPLOYEES.EMPLOYEE_ID%TYPE;                                    

    FUNCTION F_COD_DEPARTAMENT(NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
        RETURN EMPLOYEES.DEPARTMENT_ID%TYPE;
                                            
    -- C)
    FUNCTION F_NR_SUBALT(NUME EMPLOYEES.LAST_NAME%TYPE,
                         PRENUME EMPLOYEES.FIRST_NAME%TYPE)
    RETURN NUMBER;                        
    -- F)
    CURSOR C_LISTA_JOB(COD_JOB EMPLOYEES.JOB_ID%TYPE) RETURN EMPLOYEES%ROWTYPE;
    -- G)
    CURSOR C_LISTA_JOBURI_COMPANIE IS
        SELECT DISTINCT JOB_ID 
        FROM EMPLOYEES;
       
    --de aici pana la end contributie proprie 
    --B) 
    PROCEDURE mov_emp(nume employees.last_name%type,
                        prenume employees.first_name%type,
                        depName departments.department_name%type,
                        jobName jobs.job_title%type,
                        manNume employees.last_name%type,
                        manPrenume employees.first_name%type);
    
    --D)
    PROCEDURE promote(nume employees.last_name%type,                            --promovez pe urmatoarea idee: daca e om mai sus decat el in acelasi departament,
                        prenume employees.first_name%type);                      --ii dau acelasi job si sef ca omul imediat mai sus(dar las orice alta data la fel). Daca e deja pe cea mai inalta
                                                                                --pozitie din departamentul lui, iar seful lui e din alt departament sau e patronul,
                                                                                --dau exceptie
                                                                                
    --E)
    PROCEDURE updateSal (salariu employees.salary%type,
                        nume employees.last_name%type);
    
    
    --H)
    PROCEDURE exH;
    
    
END PACHET1_REZ;
/

CREATE OR REPLACE PACKAGE BODY PACHET1_REZ AS 
    -- CURSOARELE SE DECLARA LA INCEPUT!!!
    CURSOR C_LISTA_JOB(COD_JOB EMPLOYEES.JOB_ID%TYPE) RETURN EMPLOYEES%ROWTYPE IS
        SELECT * 
        FROM EMPLOYEES 
        WHERE COD_JOB = JOB_ID;



    --start contributie proprie
    
    --B)
    
    FUNCTION F_COD_emp(NUME_emp EMPLOYEES.LAST_NAME%TYPE,                       ---copy paste cu putina modificare ca sa dea exceptie diferita daca nu gaseste
                           PRENUME_emp EMPLOYEES.FIRST_NAME%TYPE)
        RETURN EMPLOYEES.EMPLOYEE_ID%TYPE IS COD_emp EMPLOYEES.EMPLOYEE_ID%TYPE:=0;
    BEGIN
        SELECT EMPLOYEE_ID INTO COD_emp
        FROM EMPLOYEES
        WHERE LAST_NAME = NUME_emp AND FIRST_NAME = PRENUME_emp;
        
        IF COD_emp = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE ANGAJATULUI NU EXISTA');
        END IF;
        RETURN COD_emp;
    END F_COD_emp;
    
    
    
    PROCEDURE mov_emp(nume employees.last_name%type,
                        prenume employees.first_name%type,
                        depName departments.department_name%type,
                        jobName jobs.job_title%type,
                        manNume employees.last_name%type,
                        manPrenume employees.first_name%type)
    IS
    COD_JOB EMPLOYEES.JOB_ID%TYPE;
    COD_DEPARTAMENT EMPLOYEES.DEPARTMENT_ID%TYPE;
    COD_MANAGER EMPLOYEES.EMPLOYEE_ID%TYPE;
    cod_emp employees.employee_id%type;
    salNou EMPLOYEES.SALARY%TYPE:=0;
    salCur EMPLOYEES.SALARY%TYPE:=0;
    comision employees.commission_pct%type;
    hireDateInit employees.hire_date%type;
    BEGIN
    
    COD_JOB := F_COD_JOB(jobName);                                  ---exceptiile tratate in functiile astea
    COD_DEPARTAMENT := F_COD_DEPARTAMENT(depName);
    COD_MANAGER := F_COD_MANAGER(manNume, manPrenume);
    cod_emp := f_cod_emp(nume, prenume);
    
    select hire_date into hireDateInit
    from employees
    where employee_id = cod_emp;
    
    select salary into salCur
    from employees
    where employee_id = cod_emp;
    
    select min(salary) into salNou
    from employees
    where job_id = cod_job and cod_departament = department_id;
    
    if (salNou > salCur) then
        salCur := salNou;
    end if;
    
    select min(nvl(commission_pct, 0)) into comision
    from employees
    where job_id = cod_job and cod_departament = department_id;
    
    if (comision = 0) then
        comision := null;
    end if;
    
    insert into job_history
    values (cod_emp, hireDateInit, sysdate, (select job_id from employees where employee_id = cod_emp), (select department_id from employees where employee_id = cod_emp));
    
    update employees
    set job_id = cod_job, department_id = cod_departament, salary = salNou, commission_pct = comision, manager_id = cod_manager, hire_date = sysdate
    where employee_id = cod_emp;
    
    END;
    
    
    --D)
    PROCEDURE promote(nume employees.last_name%type,                            
                        prenume employees.first_name%type)
    IS
    cod_emp employees.employee_id%type;
    dep_emp employees.department_id%type;
    dep_man employees.department_id%type;
    cod_man employees.employee_id%type;
    BEGIN
    cod_emp := f_cod_emp(nume, prenume);
    
    select manager_id into cod_man
    from employees
    where employee_id = cod_emp;
    
    if (cod_man is null) then
        raise_application_error(-20001, 'angajatul ales nu are manager');
    end if;
    
    select department_id into dep_emp
    from employees
    where employee_id = cod_emp;
    
    select department_id into dep_man
    from employees
    where employee_id = cod_man;
    
    if (dep_man <> dep_emp) then
        raise_application_error(-20002, 'angajatul este deja in varful departamentului sau');
    end if;
    
    update employees
    set manager_id = (select manager_id from employees where employee_id = cod_man), job_id = (select job_id from employees where employee_id = cod_man)
    where employee_id = cod_emp;
    
    END promote;
    
    
    --E)
    PROCEDURE updateSal (salariu employees.salary%type,
                        nume employees.last_name%type)
    IS
    cod_emp employees.employee_id%type;
    limSup jobs.max_salary%type;
    limInf jobs.min_salary%type;
    BEGIN
    select employee_id into cod_emp
    from employees where last_name = nume;
    
    select max_salary, min_salary into limSup, limInf
    from jobs
    where job_id = (select job_id from employees where employee_id = cod_emp);
    
    if (salariu >= limInf and salariu <= limSup) then
        update employees
        set salary = salariu
        where cod_emp = employee_id;
    end if;
    
    EXCEPTION
        when too_many_rows then
            dbms_output.put_line('exista mai mult de un angajat cu numele asta');
            for c in (select last_name, first_name from employees where last_name = nume) loop
                dbms_output.put_line(c.last_name || ' ' || c.first_name);
            end loop;
            raise_application_error(-20004, 'prea multi!');
        when no_data_found then
            raise_application_error(-20004, 'niciunul!');
                
    end updateSal;
    
    --H)
    procedure exH 
    IS
        trecut number;
        numJob jobs.job_title%type;
    BEGIN
    for c1 in c_lista_joburi_companie loop
        select job_title into numJob from jobs where job_id = c1.job_id;
        dbms_output.put_line('Pentru jobul ' || numJob || ' avem urmatorii angajati:');          ---posibil nevoie sa scihimb urat
        for c2 in c_lista_job(c1.job_id) loop
            dbms_output.put(c2.last_name || ' ' || c2.first_name);
            trecut := 0;
            select 1 into trecut 
            from dual
            where exists (select 1 from job_history where c2.employee_id = employee_id and c1.job_id = job_id); 
            if (trecut = 1) then
                dbms_output.put(': a mai lucrat aici inainte');
            end if;
            dbms_output.new_line;
        end loop;
    end loop;
    end exH;
    
    
    --end contributie proprie

        
    PROCEDURE P_ADAUG(NUME EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME EMPLOYEES.FIRST_NAME%TYPE,
                                        TELEFON EMPLOYEES.PHONE_NUMBER%TYPE,
                                        EMAIL EMPLOYEES.EMAIL%TYPE,
                                        NUME_JOB JOBS.JOB_TITLE%TYPE, 
                                        NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE,
                                        NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
    IS 
        COD_JOB EMPLOYEES.JOB_ID%TYPE;
        COD_DEPARTAMENT EMPLOYEES.DEPARTMENT_ID%TYPE;
        COD_MANAGER EMPLOYEES.EMPLOYEE_ID%TYPE;
        SALARIU EMPLOYEES.SALARY%TYPE:=0;
    BEGIN 
        COD_JOB := F_COD_JOB(NUME_JOB);
        COD_DEPARTAMENT := F_COD_DEPARTAMENT(NUME_DEPARTAMENT);
        COD_MANAGER := F_COD_MANAGER(NUME_MANAGER, PRENUME_MANAGER);
        
        SELECT MIN(SALARY) INTO SALARIU
        FROM EMP_PROF
        WHERE JOB_ID = COD_JOB AND DEPARTMENT_ID = COD_DEPARTAMENT;
        
        INSERT INTO EMP_PROF VALUES (302, NUME, PRENUME, EMAIL, TELEFON, 
                                     SYSDATE, COD_JOB, SALARIU, NULL, 
                                     COD_MANAGER, COD_DEPARTAMENT);
    END P_ADAUG;
    
    FUNCTION F_COD_JOB(NUME_JOB JOBS.JOB_TITLE%TYPE)
        RETURN EMPLOYEES.JOB_ID%TYPE IS COD_JOB EMPLOYEES.JOB_ID%TYPE:='nimic'; 
    BEGIN 
        SELECT JOB_ID INTO COD_JOB
        FROM JOBS
        WHERE JOB_TITLE = NUME_JOB;
        
        IF COD_JOB = 'nimic' THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE JOBULUI NU EXISTA');
        END IF;
        RETURN COD_JOB;
    END F_COD_JOB;

    FUNCTION F_COD_MANAGER(NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                           PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE)
        RETURN EMPLOYEES.EMPLOYEE_ID%TYPE IS COD_MANAGER EMPLOYEES.EMPLOYEE_ID%TYPE:=0;
    BEGIN
        SELECT EMPLOYEE_ID INTO COD_MANAGER
        FROM EMPLOYEES
        WHERE LAST_NAME = NUME_MANAGER AND FIRST_NAME = PRENUME_MANAGER;
        
        IF COD_MANAGER = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE MANAGERULUI NU EXISTA');
        END IF;
        RETURN COD_MANAGER;
    END F_COD_MANAGER;

    FUNCTION F_COD_DEPARTAMENT(NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
        RETURN EMPLOYEES.DEPARTMENT_ID%TYPE IS COD_DEPARTAMENT EMPLOYEES.DEPARTMENT_ID%TYPE:=0; 
    BEGIN 
        SELECT DEPARTMENT_ID INTO COD_DEPARTAMENT
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = NUME_DEPARTAMENT;
        
        IF COD_DEPARTAMENT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE DEPARTAMENTULUI NU EXISTA');
        END IF;
        RETURN COD_DEPARTAMENT;
    END F_COD_DEPARTAMENT;
    
    FUNCTION F_NR_SUBALT(NUME EMPLOYEES.LAST_NAME%TYPE,
                        PRENUME EMPLOYEES.FIRST_NAME%TYPE)
        RETURN NUMBER IS 
            NUMARATOR NUMBER:=0;
            COD_SEF EMPLOYEES.EMPLOYEE_ID%TYPE;
    BEGIN 
        COD_SEF := F_COD_MANAGER(NUME, PRENUME);

        DBMS_OUTPUT.PUT_LINE(COD_SEF);
        SELECT COUNT(*) INTO NUMARATOR
        FROM EMPLOYEES
        START WITH EMPLOYEE_ID = COD_SEF
        CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;

        RETURN NUMARATOR;        
    END F_NR_SUBALT;
        
END PACHET1_REZ;
/

BEGIN
    PACHET1_REZ.P_ADAUG('ROGOZ', 'ANA', 'bb','aa', 'Programmer', 'Ernst', 'Bruce', 'IT');
END;
/

DECLARE 
    NR NUMBER;
BEGIN
    NR := PACHET1_REZ.F_NR_SUBALT('Kochhar', 'Neena');
    DBMS_OUTPUT.PUT_LINE('Kochhar Neena ' || NR);
END;
/

BEGIN 
    FOR V_CURSOR IN PACHET1_REZ.C_LISTA_JOB('IT_PROG') LOOP
        DBMS_OUTPUT.PUT_LINE(V_CURSOR.LAST_NAME || ' ' || V_CURSOR.FIRST_NAME);
    END LOOP;
END;
/

BEGIN 
    FOR V_CURSOR IN PACHET1_REZ.C_LISTA_JOBURI_COMPANIE LOOP
        DBMS_OUTPUT.PUT_LINE(V_CURSOR.JOB_ID);
    END LOOP;
END;
/
SELECT * FROM EMP_PROF;



SET SERVEROUTPUT ON;