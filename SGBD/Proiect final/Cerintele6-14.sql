--4

drop sequence secv_id;
drop table OCUP_OM;
drop table SUPRAVEGHERE;
drop table SUSPICIUNE_CRIMA;
drop table PERSOANA_JURIDICA;
drop table PERSOANA_FIZICA;
drop table OCUPATIE;
drop table INTERES_OM;
drop table SUBIECT;
drop table INTERESE;
drop table INDUSTRIE;
drop table CRIME;
drop table AGENTT;
drop table SEDIU;
drop table PUNCT_SUPRAVEGHERE;


create sequence secv_id
increment by 1
start with 10000
maxvalue 99999
cycle
nocache;

create table PUNCT_SUPRAVEGHERE(
    pct_supra_id number(5) constraint pk_pct_suprav primary key,
    tip varchar(20) constraint nn_tip_pctsupra not null,
    data_amplasare date default sysdate,
    proximitate_subiect number(4),
    nivel_compromitere number(1)
);

create table SEDIU(
    sediu_id number(5) constraint pk_sed primary key,
    nume varchar(20) constraint nn_nume_sediu not null,
    oras varchar(15),
    strada varchar(15),
    nr_strada number(4)
);

create table AGENTT(
    agent_id number(5) constraint pk_age primary key,
    nume varchar(10) constraint nn_nume_age not null,
    prenume varchar(10) constraint nn_prenume_age not null,
    salariu number(6),
    hire_date date,
    sediu_id number(5) constraint fk_sed_age references SEDIU(sediu_id),
    rang number(1)
);

create table CRIME(
    crima_id number(5) constraint pk_crime primary key,
    nume varchar(15) constraint nn_nume_crime not null,
    nivel_sfidare_stat number(1),
    buget_alocat number(9)
);

create table INDUSTRIE(
    industrie_id number(5) constraint pk_ind primary key,
    nume varchar(15) constraint nn_nume_ind not null,
    contribuit_pib varchar(12),
    grad_risc number(1)
);

create table INTERESE(
    interes_id number(5) constraint pk_int primary key,
    nume varchar(25) constraint nn_nume_int not null,
    risc_criminalitate number(1),
    cost_mediu number(6)
);

create table SUBIECT(
    subiect_id number(5) constraint pk_subiect primary key,
    pct_supra_id number(5) constraint fk_pct_suprav_sub references PUNCT_SUPRAVEGHERE(pct_supra_id) constraint un_pct_supra_sub unique,
    coef_risc number(2)
);

create table INTERES_OM(
    interes_id number(5),
    subiect_id number(5) constraint fk_sub_int_om references SUBIECT(subiect_id) on delete cascade,
    constraint pk_int_om primary key(interes_id, subiect_id),
    constraint fk_int_int_om foreign key(interes_id) references INTERESE(interes_id)
);



create table OCUPATIE(
    ocup_id number (5) constraint pk_ocup primary key,
    nume_ocup varchar(15) constraint nn_nume_ocup not null,
    venit_max number(6) constraint nn_vmax_ocup not null,
    venit_min number(6) constraint nn_vmin_ocup not null
);

create table PERSOANA_FIZICA(
    subiect_id number(8) constraint pk_pers_fiz primary key,
    cnp varchar(14) constraint nn_cnp_persfiz not null constraint un_cnp_persfiz unique,
    nume varchar (20) constraint nn_nume_persfiz not null,
    prenume varchar (20) constraint nn_prenume_persfiz not null,
    data_nastere date,
    serie_ci varchar(3),
    nr_ci varchar(7)
);

create table PERSOANA_JURIDICA(
    subiect_id number(5) constraint pk_pers_jur primary key,
    nr_inreg varchar(15) constraint nn_inreg_pers_jur not null constraint un_inreg_persjur unique,
    nr_fiscal varchar(15)constraint nn_fisc_pers_jur not null constraint un_fisc_persjur unique,
    cod_caen varchar(5) constraint nn_caen_persjur not null,
    data_infiintare date,
    cifra_afaceri varchar(10),
    actionar_principal varchar(25),
    nume varchar(20) constraint nn_nume_persjur not null
);

create table SUSPICIUNE_CRIMA(
    subiect_id number(5) constraint fk_sub_sus references SUBIECT(subiect_id) on delete cascade,
    crima_id number(5) constraint fk_crima_sus references CRIME(crima_id) on delete cascade,
    data_comitere date constraint nn_data_sus not null,
    durata_comitere number(3) default 1,
    constraint pk_sus primary key(subiect_id, crima_id)
);

create table SUPRAVEGHERE(
    subiect_id number(5) constraint fk_sub_suprav references SUBIECT(subiect_id) on delete cascade,
    agent_id number(5) constraint fk_age_suprav references AGENTT(agent_id) on delete cascade,
    data_incepere date,
    constraint pk_suprav primary key(subiect_id, agent_id)
);

create table OCUP_OM(
    subiect_id number(5) constraint fk_sub_ocupom references SUBIECT(subiect_id) on delete cascade,
    ocup_id number(5) constraint fk_ocup_ocupom references OCUPATIE(ocup_id),
    industrie_id number(5) constraint fk_int_ocupom references INDUSTRIE(industrie_id),
    salariu number (5),
    angajator varchar(20),
    constraint pk_ocupom primary key(subiect_id, ocup_id, industrie_id)
);


--5

insert into PUNCT_SUPRAVEGHERE values(secv_id.nextval, 'duba', to_date('01-01-2018', 'dd-mm-yyyy'), 150, 6);
insert into PUNCT_SUPRAVEGHERE values(secv_id.nextval, 'stand limonada', to_date('10-05-2020', 'dd-mm-yyyy'), 500, 4);
insert into PUNCT_SUPRAVEGHERE values(secv_id.nextval, 'fereastra apartament', to_date('15-06-2021', 'dd-mm-yyyy'), 950, 1);
insert into PUNCT_SUPRAVEGHERE values(secv_id.nextval, 'duba', to_date('01-01-2022', 'dd-mm-yyyy'), 50, 5);
insert into PUNCT_SUPRAVEGHERE values(secv_id.nextval, 'masina veche', sysdate-50, 250, 7);


insert into SEDIU values(secv_id.nextval, 'Birou Central', 'Bucuresti', 'Str. Puterii', 432);
insert into SEDIU values(secv_id.nextval, 'Filiala Iasi', 'Iasi', 'Str. Palas', 54);
insert into SEDIU values(secv_id.nextval, 'Subsectie 7', 'Bucuresti', 'Ale. Ascunsa', 1);
insert into SEDIU values(secv_id.nextval, 'Centrul Anti-Mafie', 'Craiova', 'Bd. Sabiilor', 15);
insert into SEDIU values(secv_id.nextval, 'Institutul Visinescu', 'Constanta', 'Str. Inecului', 44);


insert into AGENTT values (secv_id.nextval ,'Popescu', 'Vasile', 64532, to_date('15-02-2009', 'dd-mm-yyyy'), 10007, 6);
insert into AGENTT values (secv_id.nextval ,'Marinescu', 'Marian', 10000, to_date('16-07-2018', 'dd-mm-yyyy'), 10005, 3);
insert into AGENTT values (secv_id.nextval ,'Enea', 'Robert', 23114, to_date('10-10-2014', 'dd-mm-yyyy'), 10005, 6);
insert into AGENTT values (secv_id.nextval ,'Joacabine', 'Mirel', 23425, to_date('17-11-2016', 'dd-mm-yyyy'), 10008, 5);
insert into AGENTT values (secv_id.nextval ,'Rocadura', 'Artur', 234533, to_date('11-11-2000', 'dd-mm-yyyy'), 10006, 9);

insert into CRIME values(secv_id.nextval, 'terorism', 6, 90000000);
insert into CRIME values(secv_id.nextval, 'inalta tradare', 8, 60500000);
insert into CRIME values(secv_id.nextval, 'spionaj', 7, 80500000);
insert into CRIME values(secv_id.nextval, 'delapidare', 3, 9950000);
insert into CRIME values(secv_id.nextval, 'atac cibernetic', 6, 99999999);


insert into INDUSTRIE values(secv_id.nextval, 'horeca', '5000025342', 3);
insert into INDUSTRIE values(secv_id.nextval, 'autoturisme', '12573864243', 5);
insert into INDUSTRIE values(secv_id.nextval, 'farmaceutice', '7893543544', 8);
insert into INDUSTRIE values(secv_id.nextval, 'IT', '35000124353', 7);
insert into INDUSTRIE values(secv_id.nextval, 'politica', null, 5);


insert into INTERESE values(secv_id.nextval, 'activitati montane', 2, 1000);
insert into INTERESE values(secv_id.nextval, 'jocuri de noroc', 7, 5000);
insert into INTERESE values(secv_id.nextval, 'gaming', 3, 300);
insert into INTERESE values(secv_id.nextval, 'calatorii spontane', 8, 6000);
insert into INTERESE values(secv_id.nextval, 'petreceri interlopi', 9, 40000);

insert into SUBIECT values(secv_id.nextval, 10000, 3);
insert into SUBIECT values(secv_id.nextval, 10001, 7);
insert into SUBIECT values(secv_id.nextval, null, 5);
insert into SUBIECT values(secv_id.nextval, 10002, 4);
insert into SUBIECT values(secv_id.nextval, null, 3);
insert into SUBIECT values(secv_id.nextval, null, 7);
insert into SUBIECT values(secv_id.nextval, null, 8);
insert into SUBIECT values(secv_id.nextval, null, 8);
insert into SUBIECT values(secv_id.nextval, 10004, 4);
insert into SUBIECT values(secv_id.nextval, null, 1);
insert into SUBIECT values(secv_id.nextval, null, 3);
insert into SUBIECT values(secv_id.nextval, null, 2);
insert into SUBIECT values(secv_id.nextval, null, 4);
insert into SUBIECT values(secv_id.nextval, 10003, 5);
insert into SUBIECT values(secv_id.nextval, null, 3);
insert into SUBIECT values(11111, null, 6);

insert into INTERES_OM values (10026, 10034);
insert into INTERES_OM values (10027, 10036);
insert into INTERES_OM values (10026, 10041);
insert into INTERES_OM values (10029, 10041);
insert into INTERES_OM values (10029, 10042);
insert into INTERES_OM values (10025, 10035);
insert into INTERES_OM values (10028, 10032);
insert into INTERES_OM values (10026, 10036);
insert into INTERES_OM values (10029, 10039);
insert into INTERES_OM values (10025, 10043);
insert into INTERES_OM values (10025, 10036);
insert into INTERES_OM values (10027, 10035);
insert into INTERES_OM values (10027, 10043);

insert into OCUPATIE values(secv_id.nextval, 'motostivuitor', 4000, 1500);
insert into OCUPATIE values(secv_id.nextval, 'inginer', 12000, 3500);
insert into OCUPATIE values(secv_id.nextval, 'chimist', 8000, 2000);
insert into OCUPATIE values(secv_id.nextval, 'programator', 60000, 3500);
insert into OCUPATIE values(secv_id.nextval, 'tester', 5000, 2000);
insert into OCUPATIE values(11000, 'barman', 4000, 1500);

insert into PERSOANA_FIZICA values (10032, 6030116196416, 'Nemtanu', 'Violeta', to_date('16-01-2003', 'dd-mm-yyyy'), 'MZ', '724312');
insert into PERSOANA_FIZICA values (10034, '1940728155764', 'Vasilescu', 'Ion', to_date('28-07-1994', 'dd-mm-yyyy'), 'MX', '483945');
insert into PERSOANA_FIZICA values (10035, '1880109244504', 'Mormon', 'Marius', to_date('09-01-1988', 'dd-mm-yyyy'), 'MZ', '457453');
insert into PERSOANA_FIZICA values (10036, '1870218196401', 'Cormen', 'Vioren', to_date('18-02-1987', 'dd-mm-yyyy'), 'IO', '275421');
insert into PERSOANA_FIZICA values (10039, '2931212053701', 'Magdon', 'Magdalena', to_date('12-12-1993', 'dd-mm-yyyy'), 'VE', '348562');
insert into PERSOANA_FIZICA values (10041, '5000904137459', 'Verestiuc', 'Radu', to_date('04-09-2000', 'dd-mm-yyyy'), 'AU', '124364');
insert into PERSOANA_FIZICA values (10042, '6040406454955', 'Vararu', 'Monica', to_date('16-01-2004', 'dd-mm-yyyy'), 'BU', '854291');
insert into PERSOANA_FIZICA values (10043, '2970707087952', 'Baron', 'Robert', to_date('07-07-1997', 'dd-mm-yyyy'), 'BV', '415261');
insert into PERSOANA_FIZICA values (11111, '2970557083951', 'Paun', 'Vasile', to_date('04-02-1996', 'dd-mm-yyyy'), 'AB', '631175');


insert into PERSOANA_JURIDICA values(10030, 'J22/973/2000', 'RO13611073C', '1243', to_date('05-05-2000', 'dd-mm-yyyy'), '1325531', 'Ion Pavel', 'Trafic de pufarine');
insert into PERSOANA_JURIDICA values(10031, 'J40/1973/2015', 'RO45361325C', '4241', to_date('06-06-2016', 'dd-mm-yyyy'), '325634634', 'Victor Manea', 'Regatul Comertului');
insert into PERSOANA_JURIDICA values(10033, 'J40/1642/2011', 'RO75327543C', '1123', to_date('01-02-2011', 'dd-mm-yyyy'), '21446432', 'Alexandru Babiles', 'Tinutul Shaorma');
insert into PERSOANA_JURIDICA values(10037, 'J21/991/2008', 'RO12345678C', '1234', to_date('01-09-2008', 'dd-mm-yyyy'), '11234456', 'Ion Velcescu', 'Firma ff legala');
insert into PERSOANA_JURIDICA values(10038, 'J11/125/2001', 'RO64262233C', '4321', to_date('06-09-2001', 'dd-mm-yyyy'), '5346374574', 'Vlad Volonce', 'Baieti grei SRL');
insert into PERSOANA_JURIDICA values(10040, 'J40/111/2005', 'RO12775544C', '3221', to_date('02-02-2005', 'dd-mm-yyyy'), '5555555', 'Mircea Simionescu', 'CazinoBarr');
insert into PERSOANA_JURIDICA values(10044, 'J15/125/2020', 'RO11224464C', '123', to_date('12-12-2020', 'dd-mm-yyyy'), '125532', 'Alex Maces', 'Fabrica de barbati');


insert into SUSPICIUNE_CRIMA values(10037, 10015, to_date('15-07-2018', 'dd-mm-yyyy'), 3);
insert into SUSPICIUNE_CRIMA values(10041, 10018, to_date('19-02-2020', 'dd-mm-yyyy'), 12);
insert into SUSPICIUNE_CRIMA values(10043, 10019, to_date('12-12-2013', 'dd-mm-yyyy'), 2);
insert into SUSPICIUNE_CRIMA values(10035, 10016, to_date('01-05-2016', 'dd-mm-yyyy'), 1);
insert into SUSPICIUNE_CRIMA values(10044, 10018, to_date('02-03-2019', 'dd-mm-yyyy'), 10);
insert into SUSPICIUNE_CRIMA values(10036, 10016, to_date('02-03-2012', 'dd-mm-yyyy'), 2);
insert into SUSPICIUNE_CRIMA values(10040, 10017, to_date('15-06-2008', 'dd-mm-yyyy'), 6);
insert into SUSPICIUNE_CRIMA values(10035, 10018, to_date('28-11-2021', 'dd-mm-yyyy'), 2);
insert into SUSPICIUNE_CRIMA values(10044, 10019, to_date('26-12-2020', 'dd-mm-yyyy'), 8);
insert into SUSPICIUNE_CRIMA values(10037, 10017, to_date('22-11-2019', 'dd-mm-yyyy'), 7);


insert into SUPRAVEGHERE values(10032, 10013, to_date('16-08-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10033, 10010, to_date('19-04-2020', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10044, 10014, to_date('26-01-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10034, 10012, to_date('19-08-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10042, 10010, to_date('16-03-2019', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10044, 10013, to_date('07-12-2019', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10034, 10011, to_date('11-10-2019', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10042, 10014, to_date('06-11-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10031, 10012, to_date('21-09-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10032, 10011, to_date('13-02-2022', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10037, 10013, to_date('07-10-2016', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10038, 10011, to_date('30-06-2015', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10041, 10014, to_date('06-07-2020', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10043, 10012, to_date('21-02-2021', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10036, 10011, to_date('31-07-2020', 'dd-mm-yyyy'));
insert into SUPRAVEGHERE values(10038, 10010, to_date('26-07-2021', 'dd-mm-yyyy'));


insert into OCUP_OM values (10034, 10045, 10021, 7000, 'Tractoare si lopeti');
insert into OCUP_OM values (10032, 10048, 10024, 15000, 'Vervontis');
insert into OCUP_OM values (10042, 10046, 10020, 3500, 'Mercurian');
insert into OCUP_OM values (10041, 10049, 10022, 6432, 'Babion');
insert into OCUP_OM values (10043, 10047, 10021, 11003, 'Boninu');
insert into OCUP_OM values (10039, 10045, 10020, 5322, 'McOron');
insert into OCUP_OM values (10032, 10046, 10023, 1800, 'Qurons');
insert into OCUP_OM values (10035, 10046, 10024, 2500, 'Baban');
insert into OCUP_OM values (10035, 10047, 10022, 1532, 'Guguc');
insert into OCUP_OM values (10041, 10047, 10022, 3500, 'Lelene');
insert into OCUP_OM values (11111, 10045, 10024, 10000, 'Caroni');




--6 : subprogram stocat independent care sa utilizeze doua(trei daca sunt smecher) tipuri diferite de colectii studiate
--Cerin??: Realizati un top al performantei agentilor: Datele despre agenti vor fi afisate in ordine (id, nume, prenume, rang),
--dupa suma coeficientilor de risc ai tuturor subiectilor pe care ii au sub supraveghere. In caz de egalitate intre doi agenti, 
--departajarea va fi facuta dupa rangul agentului. Vor fi afisati si subiectii pe care ii au sub supraveghere (id, coef_risc).



CREATE OR REPLACE PROCEDURE ex6 AS
    type tipColSub is record (subId subiect.subiect_id%type, coefRisc subiect.coef_risc%type);
    type colSub is table of tipColSub;
    type tabSub is table of colSub index by pls_integer;
    subiecti tabSub;                                        --colectie de colectii de subiecti supravegheati, indexata de id-ul agentului
    
    type recAg is record(agId agentt.agent_id%type, nume agentt.nume%type, prenume agentt.prenume%type, rang agentt.rang%type);
    type tabAg is varray(20) of recAg;
    agenti tabAg := tabAg();
    
    agIdCurent agentt.agent_id%type;
BEGIN
    select a.agent_id, a.nume, a.prenume, a.rang
    bulk collect into agenti
    from agentt a left join supraveghere sup 
    on a.agent_id = sup.agent_id
    left join subiect s on s.subiect_id = sup.subiect_id
    group by a.agent_id, a.nume, a.prenume, a.rang
    order by nvl(sum(s.coef_risc), 0) desc, a.rang desc;
    
    if (agenti.count = 0) then
        raise_application_error(-20000, 'Nu exista niciun agent inregistrat');
    end if;
    for i in agenti.first..agenti.last loop
        agIdCurent := agenti(i).agId;                          
        
        select s.subiect_id, s.coef_risc                                 
        bulk collect into subiecti(agIdCurent)
        from supraveghere sup join subiect s
        on sup.subiect_id = s.subiect_id
        where sup.agent_id = agIdCurent;
        
        dbms_output.put_line('------------------------');
        dbms_output.put_line('Locul ' || i || ': agentul ' || agenti(i).nume || ' ' || agenti(i).prenume ||', cu rangul ' || agenti(i).rang || ' . Suspecti supravegheati: ');
        dbms_output.put_line('------------------------');
        if (subiecti(agIdCurent).count = 0) then
            dbms_output.put_line('Niciun suspect supravegheat');
        else
            for j in subiecti(agIdCurent).first..subiecti(agIdCurent).last loop
                dbms_output.put_line('Suspectul cu id-ul ' || subiecti(agIdCurent)(j).subId || ', cu un coeficient de risc de ' || subiecti(agIdCurent)(j).coefRisc);
            end loop;
        end if; 
    end loop; 
END ex6; 


BEGIN
    ex6();
END;
/

delete from agentt;

BEGIN
    ex6();
END;
/

rollback;

--ex 7
--nota: atributul de risc criminalitate al entitatii "interese" reprezinta o cifra (1-9)
--Cerinta: In functie de pachetul de interese ales de la tastatura dintre cele de mai jos,
--sa se afiseze toate persoanele fizice care au respectivul interes, iar pentru fiecare persoana
--fizica sa fie mentionate numele agentilor care o urmaresc
--pachet 1: interesele cu risc de criminalitate cuprins intre 1 si 3
--pachet 2: interesele cu risc de criminalitate cuprins intre 4 si 6
--pachet 3: interesele cu risc de criminalitate cuprins intre 7 si 9

create or replace procedure ex7 as
    type refcursorInt is ref cursor return interese%rowtype;
    type pers is record (subId persoana_fizica.subiect_id%type, nume persoana_fizica.nume%type, prenume persoana_fizica.prenume%type);
    type agenttt is record (nume agentt.nume%type, prenume agentt.nume%type);
    type refcursorAg is ref cursor return agenttt;
    agenti refcursorAg;
    cursInterese refcursorInt;
    pachet number := &p;
    interes interese%rowtype;
    
    numeSub persoana_fizica.nume%type;
    prenumeSub persoana_fizica.prenume%type;
    numeAg agentt.nume%type;
    prenumeAg agentt.prenume%type;
    
    cursor persFiz(interes interese.interes_id%type) is             --expresie cursor
        select distinct nume, prenume,
            cursor (select a.nume, a.prenume
                    from agentt a join supraveghere sup
                    on a.agent_id = sup.agent_id
                    where p.subiect_id = sup.subiect_id)
        from persoana_fizica p join interes_om i
        on p.subiect_id = i.subiect_id
        where i.interes_id = interes;
begin
    if (pachet = 1) then
        open cursInterese for               --cursor dinamic
            select *
            from interese
            where risc_criminalitate < 4;
    elsif (pachet = 2) then
        open cursInterese for 
                select *
                from interese
                where risc_criminalitate > 3 and risc_criminalitate < 7;
    elsif (pachet = 3) then
        open cursInterese for 
                select *
                from interese
                where risc_criminalitate > 6;
    else
        raise_application_error(-20001, 'Optiune incorecta');
    end if;
    
    loop
        fetch cursInterese into interes;
        exit when cursInterese%notfound;
        dbms_output.put_line('------------------------');
        dbms_output.put_line('Pentru interesul ' || interes.nume|| ', cu un risc de criminalitate de ' || interes.risc_criminalitate);
        dbms_output.put_line('au fost identificati urmatorii:');
        dbms_output.put_line('------------------------');
        --for i in persFiz(interes.interes_id) loop
        open persFiz(interes.interes_id);                   --cursor clasic parametrizat
        loop
            fetch persFiz into numeSub, prenumeSub, agenti;       
            exit when persFiz%notfound;
            dbms_output.put(numeSub || ' ' || prenumeSub || '; supravegheat de: ');
            loop
                fetch agenti into numeAg, prenumeAg;
                exit when agenti%notfound;
                dbms_output.put(numeAg || ' ' || prenumeAg || ', ');
            end loop;
            if (agenti%rowcount = 0) then
                dbms_output.put(' niciun agent');
            end if;
            dbms_output.new_line();
        end loop;
        if (persFiz%rowcount = 0) then
            dbms_output.put_line('Nu a fost identificat niciun subiect cu acest interes');
        end if;
        close persFiz;
    end loop;
    if cursInterese%rowcount = 0 then
        dbms_output.put_line('Nu exista niciun interes in intervalul selectat al riscului de criminalitate');
    end if;
    close cursInterese;
end ex7;
/

begin       --recompilati procedura si alegeti un alt input pentru alte rezultate
    ex7();
end;
/


--8 
--Cerinta: Sa se obtina durata dezavarsirii crimei (in luni) de care este suspectat un subiect, unde id-ul acestuia si numele crimei sunt cunoscute

create or replace function ex8(numeCr crime.nume%type, idSub subiect.subiect_id%type) return number 
is
    nonExistSubject exception;
    pragma exception_init(nonExistSubject, -20005);
    
    nonExistCrime exception;
    pragma exception_init(nonExistCrime, -20006);
    
    durata number;
    testt1 number;
begin
    select count(subiect_id) into testt1
    from subiect
    where subiect_id = idSub;
    if (testt1 = 0) then
        raise nonExistSubject;
    end if;

    select count(crima_id) into testt1
    from crime
    where upper(nume) = upper(numeCr);
    if (testt1 = 0) then
        raise nonExistCrime;
    end if;
    
    select durata_comitere into durata
    from suspiciune_crima sc join crime c
    on sc.crima_id = c.crima_id
    join subiect s
    on s.subiect_id = sc.subiect_id
    where upper(c.nume) = upper(numeCr) and idSub = s.subiect_id;
    return durata;
    
EXCEPTION
    when no_data_found then         --cand exista si crima si subiectul, dar sunt asociati
        dbms_output.put_line('Subiectul nu este suspect de aceasta crima');
    when nonExistCrime then
        dbms_output.put_line('Serviciul roman de informatii nu se ocupa cu astfel de crime');
    when nonExistSubject then
        dbms_output.put_line('Id-ul transmis nu apartine niciunui subiect inregistrat.');
    when others then
        dbms_output.put_line('Exista o eroare neprevazuta. Ceea ce nu e posibil, pentru ca noi suntem SRI si prevedem totul. Cel mai probabil
        ati ajuns aici pentru ca a gresit procesorul la calcule');
        
end ex8;

begin       --aici functioneaza
    dbms_output.put_line(ex8('terorism', 10037) || ' luni');
end;        
/
begin       --aici nu exista subiectul
    dbms_output.put_line(ex8('terorism', 10) || ' luni');
end;
/

begin       --aici nu exista crima
    dbms_output.put_line(ex8('frauda', 10037) || ' luni');
end;
/
begin       --aici exista si subiectul, si crima, dar nu exista asocierea 
    dbms_output.put_line(ex8('spionaj', 10035) || ' luni');
end;        
/


--9
--Cerinta: Sa se afiseze interesul unui subiect, despre care sunt cunoscute ocupatia si industria in care activeaza
create or replace procedure ex9(nameInd industrie.nume%type, nameOcup ocupatie.nume_ocup%type) is
    nonExistOcup exception;
    nonExistInd exception;
    tooManySubj exception;
    noSubj exception;
    pragma Exception_Init(tooManySubj, -20010);
    pragma Exception_Init(noSubj, -2009);
    pragma Exception_Init(nonExistOcup, -20007);
    pragma Exception_init(nonExistInd, -20008);
    testt number;
    interesRez interese.nume%type;
BEGIN
    select count(ocup_id) into testt
    from ocupatie
    where upper(nume_ocup) = upper(nameOcup);
    if (testt = 0) then
        raise nonExistOcup;
    end if;
    
    select count(industrie_id) into testt
    from industrie
    where upper(nume) = upper(nameInd);
    if(testt = 0) then
        raise nonExistInd;
    end if;
    
    select count (subiect_id) into testt
    from ocup_om oo join ocupatie ocup on oo.ocup_id = ocup.ocup_id
    join industrie i on i.industrie_id = oo.industrie_id
    where upper(i.nume) = upper(nameInd) and upper(ocup.NUME_OCUP) = upper(nameOcup);
    if (testt = 0) then
        raise noSubj;
    elsif (testt > 1) then
        raise tooManySubj;
    end if;
    
    select i.nume into interesRez
    from interese i join interes_om io
    on i.interes_id = io.interes_id
    join persoana_fizica pf
    on pf.subiect_id = io.subiect_id
    join ocup_om oo
    on pf.subiect_id = oo.subiect_id
    join industrie ind 
    on ind.industrie_id = oo.industrie_id
    join ocupatie ocup
    on ocup.ocup_id = oo.ocup_id
    where upper(ind.nume) = upper(nameInd) and upper(ocup.NUME_OCUP) = upper(nameOcup);
    
    dbms_output.put_line('Interesul unui subiect ce respecta acesti parametrii este ' || interesRez);
    
    exception
        when nonExistInd then
            dbms_output.put_line('Industria introdusa nu este analizata de SRI. Incercati la STS.');
        when nonExistOcup then
            dbms_output.put_line('Ocupatia introdusa nu este suficient de importanta pentru a fi urmarita de noi.');
        when tooManySubj then
            dbms_output.put_line('Exista mai mult de un subiect care se incadreaza in parametrii oferiti');
        when noSubj then
            dbms_output.put_line('Nu se incadreaza nimeni in parametrii oferiti');
        when too_many_rows then
            dbms_output.put_line('Subiectul identificat are mai mult de un singur interes');
        when no_data_found then
            dbms_output.put_line('Subiectul nu are niciun interes');
        when others then
            dbms_output.put_line('Exista o eroare neprevazuta. Ceea ce nu e posibil, pentru ca noi suntem SRI si prevedem totul. Cel mai probabil
        ati ajuns aici pentru ca a gresit procesorul la calcule');
END ex9;
/

begin     --functioneaza aici
    ex9('autoturisme', 'motostivuitor');
end;
/

begin       --nonExistInd
    ex9('agricultura', 'motostivuitor');
end;
/

begin       --nonExistOcup
    ex9('autoturisme', 'tractorist');
end;
/

begin       --tooManySubj
    ex9('farmaceutice', 'chimist');
end;
/

begin       --noSubj
    ex9('farmaceutice', 'barman');
end;
/

begin       --too_many_rows
    ex9('autoturisme', 'chimist');
end;
/

begin       --no_data_found
    ex9('politica', 'motostivuitor');
end;
/

select * from ocupatie ocup
where ocup.nume_ocup = 'inginer';


--10 si 11 sunt corelate
--Cerinta 10: Sa nu se poata insera un subiect direct in lista agregata a subiectilor
--si nici sa nu se poata sterge direct de aici

--Cerinta 11: Sa se automatizeze procesul de adaugare al subiectilor in baza de date
--La momentul adaugarii unei persoane fizice sau juridice, sa se adauge o intrare in 
--lista agregata a subiectilor, si sa se adauge o instanta de supraveghere a acestuia
--efectuata de cel mai putin solicitat agent. La momentul stergerii unei persoane
--fizice sau juridice, sa se steagra intrarea echivalenta din tabelul "subiect"

--10
create or replace package ex10aux is
    canInsert number := 0;
    idAgNesolicit agentt.agent_id%type;
end ex10aux;


create or replace trigger ex10
before insert or delete on subiect
begin
    if (ex10aux.canInsert = 0) then
        raise_application_error(-20011, 'Nu este permisa adaugarea/stergerea direct in/din acest tabel. Adaugati/stergeti in/din Persoana fizica/juridica.');
    end if;
end;

insert into SUBIECT values(111, 10000, 3);

--11

create or replace trigger ex11a1                         --pentru pers_fizica
    before insert or delete on persoana_fizica 
    for each row
begin
    ex10aux.canInsert := 1;
if inserting then
    insert into subiect values (:new.subiect_id, null, null);

    select distinct a.agent_id into ex10aux.idAgNesolicit
    from supraveghere s join agentt a
    on a.agent_id = s.agent_id (+)
    group by a.agent_id
    having count(subiect_id) = (select min(count(subiect_id))       --luam in considerare si agentii care nu supravegheaza pe nimeni
                                from supraveghere ss join agentt aa 
                                on ss.agent_id (+) = aa.agent_id
                                group by aa.agent_id)
    fetch first 1 rows only;

    insert into supraveghere
    values (:new.subiect_id, ex10aux.idAgNesolicit, sysdate);
else 
    delete from subiect where :old.subiect_id = subiect_id;

end if;
    dbms_output.put_line('Triggerul a fost declansat cu succes');

exception
    when no_data_found then
        dbms_output.put_line('Nu exista niciun agent in baza de date care il poate urmari pe acest subiect');

end ex11a1;

create or replace trigger ex11a2
after insert or delete on persoana_fizica 
    for each row
begin
    ex10aux.canInsert := 0;
end ex11a2;

insert into PERSOANA_FIZICA values (1237, 6030116111111, 'Verescu', 'Magdalena', to_date('16-01-2004', 'dd-mm-yyyy'), 'MY', '724212');
rollback;

create or replace trigger ex11b1                         --pentru pers_juridica
    before insert or delete on persoana_juridica
    for each row
begin
    ex10aux.canInsert := 1;
if inserting then
    insert into subiect values (:new.subiect_id, null, null);

    select distinct a.agent_id into ex10aux.idAgNesolicit
    from supraveghere s join agentt a
    on a.agent_id = s.agent_id (+)
    group by a.agent_id
    having count(subiect_id) = (select min(count(subiect_id))       --luam in considerare si agentii care nu supravegheaza pe nimeni
                                from supraveghere ss join agentt aa 
                                on ss.agent_id (+) = aa.agent_id
                                group by aa.agent_id)
    fetch first 1 rows only;

    insert into supraveghere
    values (:new.subiect_id, ex10aux.idAgNesolicit, sysdate);

else 
    delete from subiect where :old.subiect_id = subiect_id;    
end if;    
    dbms_output.put_line('Triggerul a fost declansat cu succes');
exception
    when no_data_found then
        dbms_output.put_line('Nu exista niciun agent in baza de date care il poate urmari pe acest subiect');

end ex11b1;

create or replace trigger ex11b2
after insert or delete on persoana_juridica
    for each row
begin
    ex10aux.canInsert := 0;
end ex11b2;

insert into PERSOANA_FIZICA values (1237, '6030116111111', 'Verescu', 'Nicoleta', to_date('07-07-1997', 'dd-mm-yyyy'), 'BV', '415261');
rollback;


--12. A nu se permite stergerea de tabele (din cauza naturii de importanta si securitate a domeniului) 
--si creearea de tabele cu un nume mai lung de 30 de caractere 


create or replace trigger ex12a                        
before create on database
begin
    if (length(ora_dict_obj_name) > 30) then
        raise_application_error(-20012, 'Lungimea numelui tabelului creat nu poate depasi 30 de caractere!');
    end if;
end ex12a;

create table testtesttesttesttesttesttesttest (idd number (5) constraint pk_test primary key);

create or replace trigger ex12b                --triggerul permite stergerea altor obiecte in afara de tabele
before drop on database
begin
    if (ora_dict_obj_type = 'TABLE') then
        raise_application_error(-20013, 'Stergerea tabelelor nu este permisa');
    end if;
end ex12b;

drop table subiect;

drop trigger ex12a;


--Ex 13. Pachet cu obiecte deja predefinite

create or replace package ex13 as
    PROCEDURE ex6;
    procedure ex7;
    function ex8(numeCr crime.nume%type, idSub subiect.subiect_id%type) return number;
    procedure ex9(nameInd industrie.nume%type, nameOcup ocupatie.nume_ocup%type);
end ex13;

create or replace package body ex13 as
    PROCEDURE ex6 AS
        type tipColSub is record (subId subiect.subiect_id%type, coefRisc subiect.coef_risc%type);
        type colSub is table of tipColSub;
        type tabSub is table of colSub index by pls_integer;
        subiecti tabSub;                                        --colectie de colectii de subiecti supravegheati, indexata de id-ul agentului
        
        type recAg is record(agId agentt.agent_id%type, nume agentt.nume%type, prenume agentt.prenume%type, rang agentt.rang%type);
        type tabAg is varray(20) of recAg;
        agenti tabAg := tabAg();
        
        agIdCurent agentt.agent_id%type;
    BEGIN
        select a.agent_id, a.nume, a.prenume, a.rang
        bulk collect into agenti
        from agentt a left join supraveghere sup 
        on a.agent_id = sup.agent_id
        left join subiect s on s.subiect_id = sup.subiect_id
        group by a.agent_id, a.nume, a.prenume, a.rang
        order by nvl(sum(s.coef_risc), 0) desc, a.rang desc;
        
        if (agenti.count = 0) then
            raise_application_error(-20000, 'Nu exista niciun agent inregistrat');
        end if;
        for i in agenti.first..agenti.last loop
            agIdCurent := agenti(i).agId;                          
            
            select s.subiect_id, s.coef_risc                                 
            bulk collect into subiecti(agIdCurent)
            from supraveghere sup join subiect s
            on sup.subiect_id = s.subiect_id
            where sup.agent_id = agIdCurent;
            
            dbms_output.put_line('------------------------');
            dbms_output.put_line('Locul ' || i || ': agentul ' || agenti(i).nume || ' ' || agenti(i).prenume ||', cu rangul ' || agenti(i).rang || ' . Suspecti supravegheati: ');
            dbms_output.put_line('------------------------');
            if (subiecti(agIdCurent).count = 0) then
                dbms_output.put_line('Niciun suspect supravegheat');
            else
                for j in subiecti(agIdCurent).first..subiecti(agIdCurent).last loop
                    dbms_output.put_line('Suspectul cu id-ul ' || subiecti(agIdCurent)(j).subId || ', cu un coeficient de risc de ' || subiecti(agIdCurent)(j).coefRisc);
                end loop;
            end if;
        end loop; 
    END ex6;
    
    procedure ex7 as
        type refcursorInt is ref cursor return interese%rowtype;
        type pers is record (subId persoana_fizica.subiect_id%type, nume persoana_fizica.nume%type, prenume persoana_fizica.prenume%type);
        type agenttt is record (nume agentt.nume%type, prenume agentt.nume%type);
        type refcursorAg is ref cursor return agenttt;
        agenti refcursorAg;
        cursInterese refcursorInt;
        pachet number := &p;
        interes interese%rowtype;
        
        numeSub persoana_fizica.nume%type;
        prenumeSub persoana_fizica.prenume%type;
        numeAg agentt.nume%type;
        prenumeAg agentt.prenume%type;
        
        cursor persFiz(interes interese.interes_id%type) is             --expresie cursor
            select distinct nume, prenume,
                cursor (select a.nume, a.prenume
                        from agentt a join supraveghere sup
                        on a.agent_id = sup.agent_id
                        where p.subiect_id = sup.subiect_id)
            from persoana_fizica p join interes_om i
            on p.subiect_id = i.subiect_id
            where i.interes_id = interes;
    begin
        if (pachet = 1) then
            open cursInterese for               --cursor dinamic
                select *
                from interese
                where risc_criminalitate < 4;
        elsif (pachet = 2) then
            open cursInterese for 
                    select *
                    from interese
                    where risc_criminalitate > 3 and risc_criminalitate < 7;
        elsif (pachet = 3) then
            open cursInterese for 
                    select *
                    from interese
                    where risc_criminalitate > 6;
        else
            raise_application_error(-20001, 'Optiune incorecta');
        end if;
        
        loop
            fetch cursInterese into interes;
            exit when cursInterese%notfound;
            dbms_output.put_line('------------------------');
            dbms_output.put_line('Pentru interesul ' || interes.nume|| ', cu un risc de criminalitate de ' || interes.risc_criminalitate);
            dbms_output.put_line('au fost identificati urmatorii:');
            dbms_output.put_line('------------------------');
            --for i in persFiz(interes.interes_id) loop
            open persFiz(interes.interes_id);                   --cursor clasic parametrizat
            loop
                fetch persFiz into numeSub, prenumeSub, agenti;       
                exit when persFiz%notfound;
                dbms_output.put(numeSub || ' ' || prenumeSub || '; supravegheat de: ');
                loop
                    fetch agenti into numeAg, prenumeAg;
                    exit when agenti%notfound;
                    dbms_output.put(numeAg || ' ' || prenumeAg || ', ');
                end loop;
                if (agenti%rowcount = 0) then
                    dbms_output.put(' niciun agent');
                end if;
                dbms_output.new_line();
            end loop;
            if (persFiz%rowcount = 0) then
                dbms_output.put_line('Nu a fost identificat niciun subiect cu acest interes');
            end if;
            close persFiz;
        end loop;
        if cursInterese%rowcount = 0 then
            dbms_output.put_line('Nu exista niciun interes in intervalul selectat al riscului de criminalitate');
        end if;
        close cursInterese;
    end ex7;
    
    function ex8(numeCr crime.nume%type, idSub subiect.subiect_id%type) return number 
    is
        nonExistSubject exception;
        pragma exception_init(nonExistSubject, -20005);
        
        nonExistCrime exception;
        pragma exception_init(nonExistCrime, -20006);
        
        durata number;
        testt1 number;
    begin
        select count(subiect_id) into testt1
        from subiect
        where subiect_id = idSub;
        if (testt1 = 0) then
            raise nonExistSubject;
        end if;
    
        select count(crima_id) into testt1
        from crime
        where upper(nume) = upper(numeCr);
        if (testt1 = 0) then
            raise nonExistCrime;
        end if;
        
        select durata_comitere into durata
        from suspiciune_crima sc join crime c
        on sc.crima_id = c.crima_id
        join subiect s
        on s.subiect_id = sc.subiect_id
        where upper(c.nume) = upper(numeCr) and idSub = s.subiect_id;
        return durata;
        
    EXCEPTION
        when no_data_found then         --cand exista si crima si subiectul, dar sunt asociati
            dbms_output.put_line('Subiectul nu este suspect de aceasta crima');
        when nonExistCrime then
            dbms_output.put_line('Serviciul roman de informatii nu se ocupa cu astfel de crime');
        when nonExistSubject then
            dbms_output.put_line('Id-ul transmis nu apartine niciunui subiect inregistrat.');
        when others then
            dbms_output.put_line('Exista o eroare neprevazuta, ceea ce nu e posibil, pentru ca noi suntem SRI si prevedem totul. Cel mai probabil
            ati ajuns aici pentru ca a gresit procesorul la calcule');
            
    end ex8;
    
    procedure ex9(nameInd industrie.nume%type, nameOcup ocupatie.nume_ocup%type) is
        nonExistOcup exception;
        nonExistInd exception;
        tooManySubj exception;
        noSubj exception;
        pragma Exception_Init(tooManySubj, -20010);
        pragma Exception_Init(noSubj, -2009);
        pragma Exception_Init(nonExistOcup, -20007);
        pragma Exception_init(nonExistInd, -20008);
        testt number;
        interesRez interese.nume%type;
    BEGIN
        select count(ocup_id) into testt
        from ocupatie
        where upper(nume_ocup) = upper(nameOcup);
        if (testt = 0) then
            raise nonExistOcup;
        end if;
        
        select count(industrie_id) into testt
        from industrie
        where upper(nume) = upper(nameInd);
        if(testt = 0) then
            raise nonExistInd;
        end if;
        
        select count (subiect_id) into testt
        from ocup_om oo join ocupatie ocup on oo.ocup_id = ocup.ocup_id
        join industrie i on i.industrie_id = oo.industrie_id
        where upper(i.nume) = upper(nameInd) and upper(ocup.NUME_OCUP) = upper(nameOcup);
        if (testt = 0) then
            raise noSubj;
        elsif (testt > 1) then
            raise tooManySubj;
        end if;
        
        select i.nume into interesRez
        from interese i join interes_om io
        on i.interes_id = io.interes_id
        join persoana_fizica pf
        on pf.subiect_id = io.subiect_id
        join ocup_om oo
        on pf.subiect_id = oo.subiect_id
        join industrie ind 
        on ind.industrie_id = oo.industrie_id
        join ocupatie ocup
        on ocup.ocup_id = oo.ocup_id
        where upper(ind.nume) = upper(nameInd) and upper(ocup.NUME_OCUP) = upper(nameOcup);
        
        dbms_output.put_line('Interesul unui subiect ce respecta acesti parametrii este ' || interesRez);
        
        exception
            when nonExistInd then
                dbms_output.put_line('Industria introdusa nu este analizata de SRI. Incercati la STS.');
            when nonExistOcup then
                dbms_output.put_line('Ocupatia introdusa nu este suficient de importanta pentru a fi urmarita de noi.');
            when tooManySubj then
                dbms_output.put_line('Exista mai mult de un subiect care se incadreaza in parametrii oferiti');
            when noSubj then
                dbms_output.put_line('Nu se incadreaza nimeni in parametrii oferiti');
            when too_many_rows then
                dbms_output.put_line('Subiectul identificat are mai mult de un singur interes');
            when no_data_found then
                dbms_output.put_line('Subiectul nu are niciun interes');
            when others then
                dbms_output.put_line('Exista o eroare neprevazuta, ceea ce nu e posibil, pentru ca noi suntem SRI si prevedem totul. Cel mai probabil
            ati ajuns aici pentru ca a gresit procesorul la calcule');
    END ex9;
    
end ex13;

--apelarea unei proceduri din pachet pentru a arata ca merge

BEGIN
    ex13.ex6();
END;
/


--ex14
--Cerinta: sa se creeze un job care adauga in fiecare zi o persoana fizica. In lipsa unui serviciu de colectare a informatiei despre acesta,
--numele, prenumele, si cnp-ul, interesele si suspiciunile sale de crima vor fi automatizate

create or replace package ex14 as
    type dateSub is record (nume persoana_fizica.nume%type, prenume persoana_fizica.prenume%type, cnp persoana_fizica.cnp%type);
    function genDateSub return dateSub;
    procedure insertDateSub(info dateSub);
    
    type dateInt is varray(50) of interese.interes_id%type;
    function genDateInt return dateInt;
    procedure insertDateInt(tabInt dateInt);
    
    type dateCr is table of crime.crima_id%type;
    function genDateCr return dateCr;
    procedure insertDateCr(tabCr dateCr);
    
    procedure init_job;
    procedure activate_job;
    procedure deact_job;
    procedure flux;
end ex14;

create or replace package body ex14 as
    type colNume is table of varchar(20);           --date private ce ne vor ajuta mai tarziu in functii
    
    numeCol colNume := colNume('Pop', 'Ionas', 'Verescu', 'Iacob', 'Mihailovici', 'Enea', 'Durea', 'Balent', 'Jantuan', 'Tescu', 'Patrevon', 'Ivasciuc', 'Anton', 'Rosca', 'Casuneanu');
    prenumeColF colNume := colNume('Elena', 'Ana', 'Miruna', 'Maria', 'Ina', 'Mara', 'Viorica', 'Jana', 'Katarina', 'Irelia', 'Carmen', 'Ioana');
    prenumeColB colNume := colNume ('Alexandru', 'Stefan', 'Andrei', 'Victor', 'Alin', 'Tudor', 'Silviu', 'Robert', 'Eduard', 'Ionut');
    idGlobal persoana_fizica.subiect_id%type;

    function genDateSub return dateSub is
        rez dateSub;
        nume persoana_fizica.nume%type;
        prenume persoana_fizica.prenume%type;
        cnp persoana_fizica.cnp%type;
        aux1 varchar(14);
        aux2 varchar(14);
        aux3 varchar(14);
    begin
        nume := numeCol(floor(dbms_random.value(1, numeCol.count+1)));
        aux1 := to_char(floor(dbms_random.value(5, 7)));
        
        if (aux1 = '5') then 
            prenume := prenumeColB(floor(dbms_random.value(1, prenumeColB.count+1)));
        else
            prenume := prenumeColF(floor(dbms_random.value(1, prenumeColF.count+1)));
        end if;
        aux2 := to_char(floor(dbms_random.value(1, 100)), 'FM00');          --FM de la fara minus
        aux3 := concat(aux1, aux2);
        aux1 := to_char(floor(dbms_random.value(1, 13)), 'FM00');
        aux3 := concat(aux3, aux1);
        aux1 := to_char(floor(dbms_random.value(1, 29)), 'FM00');
        aux3 := concat(aux3, aux1);
        aux1 := to_char(floor(dbms_random.value(0, 1000000)), 'FM000000');
        aux3 := concat(aux3, aux1);
        rez.nume := nume;
        rez.prenume := prenume;
        rez.cnp := aux3;
        return rez;
    end genDateSub;
    
    procedure insertDateSub (info dateSub) is
    begin
        insert into persoana_fizica (subiect_id, nume, prenume, cnp)
        values (idGlobal, info.nume, info.prenume, info.cnp);
    end;

    function genDateInt return dateInt is
        cateInterese number;
        tabInt dateInt;
    begin
        select count (interes_id) into cateInterese
        from interese;
        cateInterese := floor(dbms_random.value(1, cateInterese + 1));
        
        select interes_id
        bulk collect into tabInt
        from interese
        order by DBMS_RANDOM.VALUE
        fetch first cateInterese rows only;
        
        return tabInt;
    end genDateInt;
    
    procedure insertDateInt(tabInt dateInt) is
    begin
        for i in tabInt.first..tabInt.last loop
            insert into interes_om
            values (tabInt(i), idGlobal);
        end loop;
    end insertDateInt;
    
    function genDateCr return dateCr is 
        cateCrime number;
        tabCr dateCr;
    begin
        select count (crima_id) into cateCrime
        from crime;
        cateCrime := floor(dbms_random.value(1, cateCrime + 1));    

        select crima_id
        bulk collect into tabCr
        from crime
        order by DBMS_RANDOM.VALUE
        fetch first cateCrime rows only;
            
        return tabCr;
    end genDateCr;
        
        
    procedure insertDateCr(tabCr dateCr) is    
    begin
        for i in tabCr.first..tabCr.last loop
            insert into suspiciune_crima
            values (idGlobal, tabCr(i), sysdate, null);
        end loop;
    end insertDateCr;
    
    procedure flux is
    begin
        select max(subiect_id) + 1 into idGlobal
        from subiect;
        
        insertDateSub(genDateSub());
        insertDateInt(genDateInt());
        insertDateCr(genDateCr());
    end flux;
    
    procedure init_job is
        exista number := 0;
    begin
        select count(1) into exista
        from user_scheduler_jobs
        where lower(job_name) = 'flux';
        
        if (exista > 0) then
            dbms_scheduler.drop_job(job_name => 'flux');
        end if;
        
        dbms_scheduler.create_job(
        job_name => 'flux',
        job_type => 'PLSQL_BLOCK',
        job_action => 'begin ex14.flux; end;',
        start_date => systimestamp,
        repeat_interval => 'FREQ = DAILY; INTERVAL = 1',
        end_date => NULL,
        enabled => TRUE,
        comments => 'No comment');
    end init_job;
    
    procedure activate_job is
        status varchar(10);
    begin
        select enabled into status
        from dba_scheduler_jobs
        where lower(job_name) = 'flux';
        
        if (lower(status) = 'false') then
            dbms_scheduler.enable(name => 'flux');
            dbms_output.put_line('Job-ul a fost activat.');
        else
            dbms_output.put_line('Job-ul este deja activ.');
        end if;
    end activate_job;

    
    procedure deact_job is
        status varchar(10);
    begin
        select enabled into status
        from dba_scheduler_jobs
        where lower(job_name) = 'flux';
        
        if (lower(status) = 'true') then
            dbms_scheduler.disable(name => 'flux');
            dbms_output.put_line('Job-ul a fost dezactivat.');
        else
            dbms_output.put_line('Job-ul este deja inactiv.');
        end if;
    end deact_job;
    
end ex14;

begin
    ex14.flux();
end;
/
