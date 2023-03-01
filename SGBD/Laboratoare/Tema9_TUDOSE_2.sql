--Lab 6 plsql
--2
create or replace trigger lab6_ex2_tas              ---am incercat sa testez dar mai sunt multi alti triggeri care interfereaza
before update of commission_pct on employees
for each row
begin
    if (:new.commission_pct > 0.5) then
        raise_application_error(-20100, 'Valoarea comisionului nu poate depasi jumatate din cea a salariului!');
    end if;
end;

--6.
create table errData_tas (user_id varchar(20),
                          nume_bd varchar(20),
                          erori varchar(50),
                          data date);

create or replace trigger lab6_ex6_tas            --dupa mintea mea as zice ca e bine, dar imi zice insufficient privileges                 
after servererror on database
begin
    null;
exception
    when others then
        insert into errData_tas values (SYS.LOGIN_USER, SYS.DATABASE_NAME, DBMS_UTILITY.FORMAT_ERROR_STACK, sysdate);
end;