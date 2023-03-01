--Lab 4
--ex 3  -> inteleg ca "au avut cel pu?in 2 joburi diferite" se refera strict la trecut, deci fara cel pe care il au in prezent
create or replace function ex3(oras locations.city%type DEFAULT 'Rome')
return NUMBER is 
    rez number;
    amOras number;
    amOameni number;
BEGIN
    select count(distinct e.employee_id) into rez
    from employees e join departments d 
    on e.department_id = d.department_id
    join locations l
    on d.location_id = l.location_id
    where (select count (*) from job_history jh where jh.employee_id = e.employee_id) >= 2 and l.city = initcap(oras);
    
    
    amOras := 0;
    select count (*) into amOras
    from locations
    where city = initcap(oras);
    if (amOras = 0) then
        return -1;
    end if;
    amOameni := 0;
    select count (*) into amOameni
    from employees e join departments d 
    on e.department_id = d.department_id
    join locations l
    on d.location_id = l.location_id
    where l.city = initcap(oras);
    
    if (amOameni = 0) then
        return -2;
    end if;
    return rez;
END;
/
declare
    v_user varchar(20);
    namOras exception;
    namOameni exception;
    rezz number;
    pragma exception_init(namOras, -20000);                            --nu stiam sa fac exceptii nebune asa ca am invatat de la indieni
    pragma exception_init(namOameni, -20001);                          --te rog sa ne zici la laborator cum ar fi trebuit sa se faca fara astea(daca doresti evident)
begin
    select user into v_user from dual;
    rezz := ex3('Utrecht');
    case 
    when (rezz >= 0) then
        insert into info_tas values (v_user, sysdate, 'ex3', 0, 'a mers treaba');
        dbms_output.put_line(rezz);
    when (rezz = -1) then
        raise namOras;
    when (rezz = -2) then
        raise namOameni;
    end case;
    
exception
    when namOras then
        insert into info_tas values (v_user, sysdate, 'ex3', 0, 'nu exista orasul');
    when namOameni then
        insert into info_tas values (v_user, sysdate, 'ex3', 0, 'nu lucreaza nmn aici');
    when others then
        insert into info_tas values (v_user, sysdate, 'ex3', 0, 'alta eroare');  
end;
/


--ex 4
create or replace procedure ex4 (boss number) is
    cur_emp employees%rowtype;
    amBoss number;
    namBoss exception;
    pragma exception_init(namBoss, -20000);
begin
    select count (*) into amBoss
    from employees
    where manager_id = boss;
    if (amBoss = 0) then
        raise namBoss;
    end if;
    for v_emp in (select * from employees)
    loop
        cur_emp := v_emp;
        while (cur_emp.manager_id <> null or cur_emp.manager_id <> boss) loop
            select * into cur_emp from employees where employee_id = cur_emp.manager_id;
        end loop;
        if (cur_emp.manager_id = boss) then
            update employees
            SET salary = salary * 1.1
            where employee_id = v_emp.employee_id;
        end if;
    end loop;
    
end;
/

declare
    v_user varchar(20);
    namBoss exception;
    pragma exception_init(namBoss, -20000);
begin
    select user into v_user from dual;
    dbms_output.put_line(ex41(100));
    insert into info_tas values (v_user, sysdate, 'ex4', 0, 'a mers treaba');
exception
    when namBoss then
        insert into info_tas values (v_user, sysdate, 'ex4', 0, 'nu exista manager'); 
    when others then
        insert into info_tas values (v_user, sysdate, 'ex4', 0, 'alta eroare'); 
end;
/