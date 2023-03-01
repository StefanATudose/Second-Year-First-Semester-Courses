--Lab 3 plsql ex 12

DECLARE
    TYPE empref IS REF CURSOR;
    type recc is record (nume employees.last_name%type,
                        salariu employees.salary%type,
                        comision employees.commission_pct%type);
    v_emp empref;
    v_nr  INTEGER := &n;
    i recc;
BEGIN
    OPEN v_emp FOR 'SELECT last_name, salary, commission_pct ' || 'FROM employees WHERE salary > :bind_var'
        USING v_nr;

    loop
        fetch v_emp into i;
        exit when v_emp%NOTFOUND;
        if (i.comision is not null) then
            DBMS_OUTPUT.PUT_LINE('Nume: ' || i.nume || '; Salariu ' || i.salariu || '; Comision: ' || i.comision);
        else 
            DBMS_OUTPUT.PUT_LINE('Nume: ' || i.nume || '; Salariu ' || i.salariu);
        end if;
    end loop;
    close v_emp;
END;
/

