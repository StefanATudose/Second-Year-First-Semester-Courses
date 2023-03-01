CREATE OR REPLACE TRIGGER trig21_tas BEFORE
    UPDATE OF salary ON emp_tas
    FOR EACH ROW
BEGIN
    IF ( :new.salary < :old.salary ) THEN
        raise_application_error(-20002, 'program crapat');
    END IF;
END;
/

UPDATE emp_tas
SET
    salary = salary - 100;

DROP TRIGGER trig21_tas;


CREATE OR REPLACE TRIGGER trig4_tas
AFTER DELETE OR UPDATE OR INSERT OF salary ON emp_tas
FOR EACH ROW
BEGIN
IF deleting THEN
-- se sterge un angajat
    modific_plati_prof(:old.department_id, -1 * :old.salary);
ELSIF updating THEN
--se modifica salariul unui angajat
    modific_plati_prof(:old.department_id, :new.salary - :old.salary);
ELSE
-- se introduce un nou angajat
    modific_plati_prof(:new.department_id, :new.salary);
END IF;

end;
/


--1
CREATE OR REPLACE TRIGGER trig1_tas BEFORE
    delete ON dept_tas
    
BEGIN
    IF (USER != UPPER('scott')) THEN
        raise_application_error(-20006, 'Doar scott are voie');
    END IF;
END;
/
