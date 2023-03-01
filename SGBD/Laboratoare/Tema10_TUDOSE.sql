--tema 10 lab7
--ex 3

declare
    integrityException exception;
    pragma exception_init(integrityException, -02292);
begin
    update departments
    set department_id = 2
    where department_id = 20;
exception
    when integrityException then
        dbms_output.put_line('Ati incercat sa stergeti/updatati id-ul unui parinte de care depind copii. Incercati sa activati on delete cascade.');
end;

--ex 5

declare
    errr exception;
    cod departments.department_id%type := &p;
    exista number := 0;
begin
    select count(*) into exista
    from departments
    where department_id = cod;
    
    if (exista = 0) then
        raise_application_error(exceptie, -20101);
    end if;
    
    update departments
    set department_name = 'Test'
    where department_id = cod;
end;