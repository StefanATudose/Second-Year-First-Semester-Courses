--ex 2
--a) copiata de la solutii de la sfarsitul laboratorului de recap 2 si prelucrata pt luna oct, ca dupa 30 de min tot nu m am prins 
select ziua, (select count(*) from rental where to_char(book_date,'dd.mm.yyyy') = to_char(ziua,'dd.mm.yyyy')) "nr"
from  (select to_date('01-oct-2022', 'dd-mm-yy') + level-1 ziua 
from   dual
connect by level<=extract (day from last_day(sysdate))); 


--de aici in jos e numai munca proprie
--b) 

create table octombrie_tas(dat_id number(2) constraint pk_dat_id primary key,
                   data date) ;
BEGIN
    
    for i in 1..31 loop
        insert into octombrie_tas
        values (i, to_date(i || '-oct-2022', 'dd-mm-yy'));
    end loop;
END;
/

drop table octombrie_tas; --salvam spatiu


with datee as (select trunc(oct.data, 'ddd') ziua
from octombrie_tas oct join rental ren
on trunc(oct.data, 'ddd') = trunc(ren.book_date, 'ddd'))

select distinct ziua, (select count(*) from rental where trunc(book_date, 'ddd') = ziua)
from datee
union
select data, 0
from octombrie_tas
where data not in (select trunc(oct.data, 'ddd') ziua                   ---aici incercasem cu not in datee dar n-a vrut asa ca l am lasat asa ca merge
from octombrie_tas oct join rental ren
on trunc(oct.data, 'ddd') = trunc(ren.book_date, 'ddd'));


--3                    -- membrul cu id-ul 110 e adaugat de mine ca sa testez too many rows
declare 
    membru varchar(20) := initCap(lower('&nume_si_prenume'));            
    rez number(3);
begin
    select count(distinct title_id)
    into rez
    from rental r right join member m on r.member_id = m.member_id
    where m.last_name || ' ' || m.first_name = membru
    group by (m.member_id);
    dbms_output.put_line(rez);
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Niciun individ gasit cu acest nume');
    when TOO_MANY_ROWS then
        dbms_output.put_line('Prea multi indivizi cu numele asta');
end;
/

--4.
declare
    nrTitluri number(3);
    membru varchar(40) := initCap(lower('&nume_si_prenume'));
    rez number(3);
begin
    select count(distinct title_id)
    into rez
    from rental r right join member m on r.member_id = m.member_id
    where m.last_name || ' ' || m.first_name = membru
    group by (m.member_id);
    
    select count (*)
    into nrTitluri
    from title;
    dbms_output.put_line(rez || '; ');
    case
        when rez >= nrTitluri * 0.75 then dbms_output.put_line('Categoria 1');
        when rez >= nrTitluri * 0.5 then dbms_output.put_line('Categoria 2');
        when rez >= nrTitluri * 0.25 then dbms_output.put_line('Categoria 3');
        else dbms_output.put_line('Categoria 4');
    end case;
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Niciun individ gasit cu acest nume');
    when TOO_MANY_ROWS then
        dbms_output.put_line('Prea multi indivizi cu numele asta');
end;
/

--5
create table member_tas 
    as select * from member;
    
alter table member_tas
add discount number(3);

declare
    rez number(3);
    nrTitluri number(3);
    membru number(5) := &mem_id;
begin
    select count(distinct title_id)
    into rez
    from rental r right join member m on r.member_id = m.member_id
    where membru = m.member_id
    group by (m.member_id);
    
    select count (*)
    into nrTitluri
    from title;
    case
        when rez >= nrTitluri * 0.75 then update member_tas set discount =  10 where membru = member_id;
        when rez >= nrTitluri * 0.5 then update member_tas set discount =  5 where membru = member_id;
        when rez >= nrTitluri * 0.25 then update member_tas set discount =  3 where membru = member_id;
        else update member_tas set discount =  10 where membru = member_id;
    end case;
    dbms_output.put_line('Actualizare efectuata cu succes!');
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('Niciun individ gasit cu acest nume');
    when TOO_MANY_ROWS then
        dbms_output.put_line('Prea multi indivizi cu numele asta');
end;
/