create table EMP_TAS as SELECT * from Employees;

comment on table EMP_TAS is 'Tudose_Alex_Stefan';


create table DEP_TAS as SELECT * from Employees;

comment on table DEP_TAS is 'Dep+Tudose_Alex_Stefan';

select * from user_tab_comments where upper(table_name) = upper('emp_tas');

ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY HH24:MI::SS';

SELECT EXTRACT(DAY FROM SYSDATE), EXTRACT(MONTH from SYSDATE) FROM dual;

--16
select table_name from user_tables
where table_name like upper ('%tas');

--17.
select 'drop table ' ||table_name||';'  
FROM   user_tables 
WHERE  table_name LIKE UPPER('%_prof');   

spool c:\TOATE\sterg_tabele.sql
select 'drop table ' ||table_name||';'  
FROM   user_tables 
WHERE  table_name LIKE UPPER('%_prof'); 
commit;
spool off;

--19.
set feedback off;

set feedback on;

--20. 
set pagesize 0;

--23.
SELECT 

'INSERT INTO departments VALUES 

  (' || department_id || ', ''' || department_name || 

   ''', ' || location_id || ');' 

  AS "Inserare date" 

FROM   departments; 


--Lab 2
--4.
select category, count(copy_id), count(distinct tt.title_id)
from rental rr, title tt
where (rr.title_id = tt.title_id)
group by category
having count(*) = ( select
max(count (*))
from rental r, title t
where r.title_id = t.title_id
group by category);

--5. al meu
select title, count(distinct(tc.copy_id))
from title t join title_copy tc
on t.title_id = tc.title_id
join rental r on r.title_id = t.title_id
where r.act_Ret_date < sysdate
group by title;

--5. al rpofei
select title_id, count(copy_id)
from title_copy t
where(title_id, copy_id) not in (select title_id, copy_id
                                    from rental
                                    where act_ret_date is null)
group by title_id;

--6. 
select title_id, copy_id, status, case
    when ((title_id, copy_id) not in (select title_id, copy_id
                                    from rental
                                    where act_ret_date is null))
        then 'available'
    else 'rented'
    end
from title_copy;

--7. 
select count (*)
from title_copy
where lower(status) <> case
                                when ((title_id, copy_id) not in (select title_id, copy_id
                                        from rental
                                        where act_ret_date is null))
                                then 'available'
                                else 'rented'
                        end;
                        
--b.
create table title_copy_tas
as select * from title_copy;

update title_copy_tas
set status =  case
                    when ((title_id, copy_id) not in (select title_id, copy_id
                                from rental
                                 where act_ret_date is null))
                    then 'available'
                    else 'rented'
                end;
                
--8.
select case
        when (select count(*) from reservation res join rental ren on res.title_id = ren.title_id where book_date = res_date) = (select count(*) from reservation) then 'da'
        else 'nu'
        end
from dual;
        
--9.
select m.last_name || ' ' || m.first_name "nume si prenume", t.title, count(*)
from member m, title t, rental r
where m.member_id = r.member_id and t.title_id = r.title_id
group by m.last_name, m.first_name, t.title;

--Lab 2, 20 oct

--10. var mea, de vazut
select distinct m.last_name || ' ' || m.first_name "nume si prenume", t.title, tc.copy_id, count(r.copy_id)
from member m, title_copy tc , rental r, title t
where m.member_id = r.member_id and t.title_id = r.title_id and tc.copy_id = r.copy_id
group by m.last_name, m.first_name, tc.copy_id, t.title;

-- var nicu, buna
select m.last_name,m.first_name,r.copy_id,r.title_id,count(r.copy_id) 
from member m, rental r 
where m.member_id=r.member_id 
group by m.last_name,m.first_name,r.copy_id,r.title_id; 

--11. var mea
select tc.status, tc.title_copy, tc.title
from title_copy tc join rental r
on tc.title_copy = r.title_copy
join title t on t.tile = tc.title
where count(*) = (select max(count(*)) from rental group by title_id)
group by t.title_id, tc.status, tc.title_copy, tc.title;

--var bun
with info as 
    (select t.title_id, title, c.copy_id, max(status), count(*) nr 
    from   title t, title_copy c, rental r 
    where  t.title_id = c.title_id 
    and    c.copy_id = r.copy_id 
    and    c.title_id = r.title_id 
    group by t.title_id, title, c.copy_id) 
     
select * 
from   info i 
where  nr = (select max(nr) 
             from info 
             where title_id = i. title_id) 
order by 1; 

--12.a
select count(*)
from rental
where extract (day from book_date) = '1' or extract( day from book_date) = '2' and extract (month from book_date) = extract (month from sysdate);

--b

select extract (day from book_date), count (*)
from rental
where extract(month from book_date) = extract (month from sysdate)
group by extract (day from book_date);



--c
select ziua, (select count(*) from rental where to_char(book_date,'dd.mm.yyyy') = to_char(ziua,'dd.mm.yyyy')) as nr 
from  (select trunc(sysdate,'month') + level-1 ziua 
from   dual 
connect by level<=extract (day from last_day(sysdate))); 

--Lab6
DECLARE
    TYPE salut is
        varray(200) of employees.employee_id%type;
    vectAngaj salut := salut(190);
BEGIN
    select employee_id
    into vectAngaj
    from employees;
    for i in vectAngaj.first..vectAngaj.last loop 
        DBMS_OUTPUT.PUT(vectAngaj(i) || ' ');
    end loop;
        
END;
/


select CASE 
        when count(employee_id) = 0 then 'In departamentul ' || department_name  || ' nu lucreaza niciun angajat.'
        when count (employee_id) = 1 then 'In departamentul ' || department_name || ' lucreaza un angajat'
        else 'In departamentul ' || department_name  || ' lucreaza ' || count(employee_id) || ' angajati.'
        end
    from departments d, employees e
    where d.department_id = e.department_id(+)
    group by department_name;
    

DECLARE
    TYPE tab_nume IS
        TABLE OF departments.department_name%TYPE;
    TYPE tab_nr IS
        TABLE OF NUMBER(4);
    t_nr   tab_nr;
    t_nume tab_nume;

BEGIN
    SELECT
        department_name    nume,
        COUNT(employee_id) nr
    BULK COLLECT INTO t_nume, t_nr 
    FROM
        departments d,
        employees   e
    WHERE
        d.department_id = e.department_id (+)
    GROUP BY
        department_name;
    FOR i IN t_nume.first..t_nume.last LOOP
        IF t_nr(i) = 0 THEN
            dbms_output.put_line('In departamentul '
                                 || t_nume(i)
                                 || ' nu lucreaza angajati');
        ELSIF t_nr(i) = 1 THEN
            dbms_output.put_line('In departamentul '
                                 || t_nume(i)
                                 || ' lucreaza un angajat');
        ELSE
            dbms_output.put_line('In departamentul '
                                 || t_nume(i)
                                 || ' lucreaza '
                                 || t_nr(i)
                                 || ' angajati');
        END IF;
    END LOOP;

END;
/

select * from (select e1.first_name, count (distinct e.employee_id)
from employees e join employees e1
on e.manager_id = e1.employee_id
group by e1.first_name
order by count (e.employee_id) desc)
where rownum <= 5;


--10
DECLARE
    v_nume employees.last_name%type;
    TYPE tab_nume IS
        TABLE OF departments.department_name%TYPE;
    TYPE tab_nr IS
        TABLE OF NUMBER(4);
    t_id   tab_nr;
    t_nume tab_nume;
    CURSOR c IS
    SELECT
        department_name    nume,
        department_id idd
    FROM
        departments d
    WHERE
        d.department_id = 10 or d.department_id = 20 or d.department_id = 30 or d.department_id = 40 ;
    CURSOR cc (depp NUMBER) IS
    SELECT
        last_name
    FROM
        employees   e
    WHERE
        department_id = depp;
BEGIN
    OPEN c;
    FETCH c
    BULK COLLECT INTO
        t_nume,
        t_id;
    CLOSE c;
    FOR i IN t_id.first..t_id.last LOOP
        dbms_output.new_line();
        dbms_output.put_line(t_nume(i));
        open cc(t_id(i));
        LOOP
            FETCH cc INTO    v_nume;
            EXIT WHEN cc%notfound;
        dbms_output.put_line(v_nume);
        END LOOP;
        close cc;
    END LOOP;
END;
/


--Lab plsql 4
--1
create table info_tas(
    utilizator varchar(20),
    data date,
    comanda number(5),
    nr_linii number(3),
    eroare varchar(20)
);

--2
CREATE OR REPLACE FUNCTION f2_tas (
    v_nume employees.last_name%TYPE DEFAULT 'Bell'
) RETURN NUMBER IS
    salariu employees.salary%TYPE;
BEGIN
    SELECT
        salary
    INTO salariu
    FROM
        employees
    WHERE
        last_name = v_nume;

    RETURN salariu;
EXCEPTION
    WHEN no_data_found THEN
        raise_application_error(-20000, 'Nu exista angajati cu numele dat');
    WHEN too_many_rows THEN
        raise_application_error(-20001, 'Exista mai multi angajati cu numele dat');
    WHEN OTHERS THEN
        raise_application_error(-20002, 'Alta eroare!');
END f2_tas;
/


--NU PUTEM INSERT IN FCT STOCATE
DECLARE
-- parametru de tip OUT pentru NEW_LINES
-- tablou de siruri de caractere
    linii    dbms_output.chararr;
-- paramentru de tip IN OUT pentru NEW_LINES
    nr_linii INTEGER;
    v_emp    employees.employee_id%TYPE;
    v_job    employees.job_id%TYPE;
    v_dept   employees.department_id%TYPE;
BEGIN
    SELECT
        employee_id,
        job_id,
        department_id
    INTO
        v_emp,
        v_job,
        v_dept
    FROM
        employees
    WHERE
        last_name = 'Lorentz';
-- se mareste dimensiunea bufferului
    dbms_output.enable(1000000);
    dbms_output.put(' 1 '
                    || v_emp
                    || ' ');
    dbms_output.put(' 2 '
                    || v_job
                    || ' ');
    dbms_output.new_line;
    dbms_output.put_line(' 3 '
                         || v_emp
                         || ' '
                         || v_job);
    dbms_output.put_line(' 4 '
                         || v_emp
                         || ' '
                         || v_job
                         || ' '
                         || v_dept);
-- se afiseaza ceea ce s-a extras
    nr_linii := 4;
    dbms_output.get_lines(linii, nr_linii);
    dbms_output.put_line('In buffer sunt '
                         || nr_linii
                         || ' linii');
    FOR i IN 1..nr_linii LOOP
        dbms_output.put_line(linii(i));
    END LOOP;
 nr_linii := 4;
 DBMS_OUTPUT.GET_LINES(linii,nr_linii);
 DBMS_OUTPUT.put_line('Acum in buffer sunt '|| nr_linii ||' linii');
 FOR i IN 1..nr_linii LOOP
 DBMS_OUTPUT.put_line(linii(i));
 END LOOP;
--
 DBMS_OUTPUT.disable;
 DBMS_OUTPUT.enable;
----
 nr_linii := 4;
 DBMS_OUTPUT.GET_LINES(linii,nr_linii);
 DBMS_OUTPUT.put_line('Acum in buffer sunt '|| nr_linii ||' linii');
END;
/