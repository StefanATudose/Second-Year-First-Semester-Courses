--2 lab 2 plsql cu vector
create or replace type tip_orase_tas is varray(100) of varchar(20);             --din motive pe care inca nu le inteleg, nu ma lasa sa le selectez pe urmatoarele doua instructiuni impreuna si sa le rulez
                                                                                --dar daca le selectez si rulez separat aparent functioneaza
create table excursie_tas(
    cod_excursie number(4) constraint pk_cod_exc primary key,
    denumire varchar(20),
    orase tip_orase_tas,
    status varchar(10)
)
/
declare
    orasSpecif number(1);
    vectAux tip_orase_tas := tip_orase_tas();
    cate number(2);
    oras1 varchar(20);
    oras2 varchar(20);
    poz1 number(2);
    poz2 number (2);
    aux varchar (20);
begin
    insert into excursie_tas
    values (1, 'nechifor unde?', tip_orase_tas('magura tarcau', 'bicaz', 'calugareni', 'farcasa', 'borca', 'cruci', 'vatra dornei', 'brosteni', 'suha', 'sabasa'), 'disponibil');
    insert into excursie_tas
    values (2, 'sauron senpai', tip_orase_tas('shire', 'bree', 'rivendell', 'goblin-town', 'carrock', 'mordor'), 'disponibil');  
    insert into excursie_tas
    values (3, 'gon x killua ya0i', tip_orase_tas('whale island', 'hunter exam', 'zoldick town', 'heavens arena', 'yorknew city', 'greed island', 'ngl', 'hunter hq'), 'anulat');  
    insert into excursie_tas
    values (4, 'uninstall pls', tip_orase_tas('demacia', 'piltover', 'zaun', 'ionia', 'bilgewater', 'noxus', 'ixtal', 'shadow isles'), 'anulat');   
    insert into excursie_tas
    values (5, 'weeknd first tour', tip_orase_tas('vancouver', 'barcelona', 'paris', 'brussels', 'porto', 'osaka' ), 'disponibil');      
    orasSpecif := 2;
    select orase
    into vectAux
    from excursie_tas
    where cod_excursie = 2;
    vectAux.extend();
    vectAux(vectAux.last) := 'gollumtown'; --pana aici primul - din b)
/*
    for i in vectAux.first..vectAux.last loop
        dbms_output.put_line(vectAux(i));
    end loop;*/
    vectAux.extend();
    for i in reverse 2..vectAux.last-1 loop
        vectAux(i+1) := vectAux(i);
    end loop;
    vectAux(2) := 'salut';  --pana aici al doilea -
    oras1 := 'bree';
    oras2 := 'carrock';
    for i in vectAux.first..vectAux.last loop
        if (vectAux(i) = oras1) then poz1 := i; 
        end if;
        if (vectAux(i) = oras2) then poz2 := i; 
        end if;
    end loop;
    oras1 := 'gollumtown';
    for i in vectAux.first..vectAux.last loop
        if (vectAux(i) = oras1) then
            poz1 := i;
            goto iesi;
        end if;
    end loop;
    <<iesi>>
    vectAux(poz1) := null; --nu merge delete
    update excursie_tas
    set orase = vectAux
    where cod_excursie = orasSpecif;
    
    --de aici in jos pct c)
    poz1 := 4;      --fie asta codul orasului
    select orase
    into vectAux
    from excursie_tas
    where cod_excursie = poz1;
    dbms_output.put(vectAux.count() || ' ');
    for i in vectAux.first..vectAux.last loop
        if (vectAux.exists(i)) then
            dbms_output.put(vectAux(i) || ' ' );
        end if;
    end loop;
    dbms_output.new_line;
    
    --d de aici in jos
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        for j in vectAux.first..vectAux.last loop
            if (vectAux.exists(j)) then
                dbms_output.put(vectAux(j) || ' ');
            end if;
        end loop;
        dbms_output.new_line;
    end loop;
    
    --e de aici in jos -> fie poz2 numarul minim de orase vizitate sa nu ma mai pierd in variabile noi
    poz2 := 99;
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        if (vectAux.count() < poz2) then
            poz2 := vectAux.count();
        end if;
    end loop;
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        if (vectAux.count() = poz2) then
            update excursie_tas
            set status = 'anulat'
            where cod_excursie = i;
        end if;
    end loop;
    
end;
/
drop table excursie_tas;
drop type tip_orase_tas;



--ex 3 cu imbricat, ca indexat nu inteleg de ce n a vrut
create or replace type tip_orase_tas is table of varchar(20);               --la fel ca mai sus, va rog selectati si rulati pe rand

create table excursie_tas(
    cod_excursie number(4) constraint pk_cod_exc primary key,
    denumire varchar(20),
    orase tip_orase_tas,
    status varchar(10)
)nested table orase store as tabel_oras;
/
declare
    orasSpecif number(1);
    vectAux tip_orase_tas := tip_orase_tas();
    cate number(2);
    oras1 varchar(20);
    oras2 varchar(20);
    poz1 number(2);
    poz2 number (2);
    aux varchar (20);
begin
    insert into excursie_tas
    values (1, 'nechifor unde?', tip_orase_tas('magura tarcau', 'bicaz', 'calugareni', 'farcasa', 'borca', 'cruci', 'vatra dornei', 'brosteni', 'suha', 'sabasa'), 'disponibil');
    insert into excursie_tas
    values (2, 'sauron senpai', tip_orase_tas('shire', 'bree', 'rivendell', 'goblin-town', 'carrock', 'mordor'), 'disponibil');  
    insert into excursie_tas
    values (3, 'gon x killua ya0i', tip_orase_tas('whale island', 'hunter exam', 'zoldick town', 'heavens arena', 'yorknew city', 'greed island', 'ngl', 'hunter hq'), 'anulat');  
    insert into excursie_tas
    values (4, 'uninstall pls', tip_orase_tas('demacia', 'piltover', 'zaun', 'ionia', 'bilgewater', 'noxus', 'ixtal', 'shadow isles'), 'anulat');   
    insert into excursie_tas
    values (5, 'weeknd first tour', tip_orase_tas('vancouver', 'barcelona', 'paris', 'brussels', 'porto', 'osaka' ), 'disponibil');      
    orasSpecif := 2;
    select orase
    into vectAux
    from excursie_tas
    where cod_excursie = 2;
    vectAux.extend();
    vectAux(vectAux.last) := 'gollumtown'; 
/*
    for i in vectAux.first..vectAux.last loop
        dbms_output.put_line(vectAux(i));
    end loop;
*/
    vectAux.extend();
    for i in reverse 2..vectAux.last-1 loop
        vectAux(i+1) := vectAux(i);
    end loop;
    vectAux(2) := 'salut';  --pana aici al doilea -
    oras1 := 'bree';
    oras2 := 'carrock';
    for i in vectAux.first..vectAux.last loop
        if (vectAux(i) = oras1) then poz1 := i; 
        end if;
        if (vectAux(i) = oras2) then poz2 := i; 
        end if;
    end loop;
    oras1 := 'gollumtown';
    for i in vectAux.first..vectAux.last loop
        if (vectAux(i) = oras1) then
            poz1 := i;
            goto iesi;
        end if;
    end loop;
    <<iesi>>
    vectAux.delete(poz1);
    update excursie_tas
    set orase = vectAux
    where cod_excursie = orasSpecif;
    
    --de aici in jos pct c)
    poz1 := 4;      --fie asta codul orasului
    select orase
    into vectAux
    from excursie_tas
    where cod_excursie = poz1;
    dbms_output.put(vectAux.count() || ' ');
    for i in vectAux.first..vectAux.last loop
        if (vectAux.exists(i)) then
            dbms_output.put(vectAux(i) || ' ' );
        end if;
    end loop;
    dbms_output.new_line;
    
    --d de aici in jos
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        for j in vectAux.first..vectAux.last loop
            if (vectAux.exists(j)) then
                dbms_output.put(vectAux(j) || ' ');
            end if;
        end loop;
        dbms_output.new_line;
    end loop;
    
    --e de aici in jos -> fie poz2 numarul minim de orase vizitate sa nu ma mai pierd in variabile noi
    poz2 := 99;
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        if (vectAux.count() < poz2) then
            poz2 := vectAux.count();
        end if;
    end loop;
    for i in 1..5 loop
        select orase
        into vectAux
        from excursie_tas
        where cod_excursie = i;
        if (vectAux.count() = poz2) then
            update excursie_tas
            set status = 'anulat'
            where cod_excursie = i;
        end if;
    end loop;
    
end;
/
drop table excursie_tas;
drop type tip_orase_tas;
