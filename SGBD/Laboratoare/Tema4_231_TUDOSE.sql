--1 lab plsql2
declare
    type imbr is table of employees%rowtype index by pls_integer;
    vecc imbr;
    
begin
    with fr_5 as (select * from employees order by salary)
    select *
    bulk collect into vecc
    from fr_5
    where commission_pct is null and rownum <= 5;
    
    for i in vecc.first..vecc.last loop
        dbms_output.put_line('al ' || i || '-lea cel mai prost platit este ' || vecc(i).last_name || '. saracul castiga numai ' || vecc(i).salary || '. din mila, i-am marit salariul la ' || vecc(i).salary * 1.05);
        update employees
        set salary = salary * 1.05
        where employee_id = vecc(i).employee_id;
    end loop;
end;
rollback;
/


--1 scris pe teams

declare
    type codNumSalDep is record(cod employees.employee_id%type,
                                nume employees.last_name%type,
                                sal employees.salary%type,
                                dep employees.department_id%type);
    angaj200 codNumSalDep;
begin
    delete from emp_tas
    where employee_id = 200
    returning employee_id, last_name, salary, department_id
    into angaj200;
    dbms_output.put_line('l-am concediat pe ' || angaj200.nume || ' (ala cu codul ' || angaj200.cod || '). baiatul era in departamentul ' || angaj200.dep || ' si castiga ' || angaj200.sal || ' lei vechi.');
end;
rollback;
/

--2 scris pe teams
declare 
    type imbr is table of emp_tas%rowtype;
    tabl imbr := imbr();
begin
    tabl.extend();
    select * 
    into tabl(1)
    from employees
    where employee_id = 100;
    tabl(1).employee_id := 300;
    /*
    tabl(1).employee_id := 500;
    tabl(1).first_name := 'Dumitru';
    tabl(1).last_name := 'Stan';
    tabl(1).email := 'DSTAN';
    tabl(1).hire_date := sysdate;*/
    insert into emp_tas
    values tabl(1);
end;
rollback;
/


