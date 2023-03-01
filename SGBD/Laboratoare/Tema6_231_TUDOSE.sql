--Lab 3 cursoare
--1a

DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb;
    ang_curent varchar(30);
    job_prez jobs.job_title%type;
BEGIN
    open curs_jobs;
    loop
        fetch curs_jobs into job_prez;
        exit when curs_jobs%notfound;
        open curs_ang(job_prez);
        dbms_output.put_line('Pentru jobul ' || job_prez || ' angajatii sunt:' );
        loop
            fetch curs_ang into ang_curent;
            exit when curs_ang%notfound;
            dbms_output.put_line(ang_curent);
        end loop;
        if (curs_ang%rowcount = 0) then
            dbms_output.put_line('Nu sunt angajati!');
        end if;
        dbms_output.new_line();
        close curs_ang;
    end loop;
    close curs_jobs;
END;
/

--b
DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name nume
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb;
    counter number;
BEGIN
    for i in curs_jobs loop
        dbms_output.put_line('Pentru jobul ' || i.job_title || ' angajatii sunt:' );
        counter := 0;
        for j in curs_ang(i.job_title) loop
            dbms_output.put_line(j.nume);
            counter := counter +1;
        end loop;
        if (counter = 0) then
            dbms_output.put_line('De fapt nu sunt angajati la acest job!');
        end if;
        dbms_output.new_line();
    end loop;
END;
/

--c
DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name nume
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb;
    counter number;
BEGIN
    for i in (select job_title 
                from jobs)
    loop
        dbms_output.put_line('Pentru jobul ' || i.job_title || ' angajatii sunt:' );
        counter := 0;
        for j in (select last_name || ' ' || first_name nume
                    from employees e join jobs j on e.job_id = j.job_id
                     where job_title = i.job_title)
        loop
            dbms_output.put_line(j.nume);
            counter := counter +1;
        end loop;
        if (counter = 0) then
            dbms_output.put_line('De fapt nu sunt angajati la acest job!');
        end if;
        dbms_output.new_line();
    end loop;
END;
/

--d
DECLARE
    type refcursor is ref cursor;
    cursor curs_jobs is
        select job_title,
                cursor(select last_name || ' ' || first_name
                        from employees e
                        where e.job_id = j.job_id)
        from jobs j;
    curs_ang refcursor;
    job_prez jobs.job_title%type;
    ang_curent varchar(30);
BEGIN
    open curs_jobs;
    loop
        fetch curs_jobs into job_prez, curs_ang;
        exit when curs_jobs%notfound;
        dbms_output.put_line('Pentru jobul ' || job_prez || ' angajatii sunt:' );
        loop
            fetch curs_ang into ang_curent;
            exit when curs_Ang%notfound;
            dbms_output.put_line(ang_curent);
        end loop;
        if (curs_ang%rowcount = 0) then
            dbms_output.put_line('Nu sunt angajati!');
        end if;
        dbms_output.new_line();
    end loop;
    close curs_jobs;
END;
/

--In continuare fac 2 3 4 cu cursoare clasice
--2
DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb;
    ang_curent varchar(30);
    job_prez jobs.job_title%type;
    val_lun number;
    val_med number;
    nr_ang number;
BEGIN
    open curs_jobs;
    loop
        fetch curs_jobs into job_prez;
        exit when curs_jobs%notfound;
        open curs_ang(job_prez);
        dbms_output.put_line('Pentru jobul ' || job_prez || ' angajatii sunt:' );
        loop
            fetch curs_ang into ang_curent;
            exit when curs_ang%notfound;
            dbms_output.put_line(curs_ang%rowcount || '. ' || ang_curent);
        end loop;
        if (curs_ang%rowcount = 0) then
            dbms_output.put_line('Nu sunt angajati!');
        elsif (curs_ang%rowcount = 1) then
            dbms_output.put_line('Asadar aici lucreaza un angajat.');
        else
            dbms_output.put_line('Asadar aici lucreaza ' || curs_ang%rowcount || ' angajati.');
        end if;
        select sum(salary), avg(salary)
        into val_lun, val_med
        from employees e, jobs j
        where e.job_id = j.job_id and j.job_title = job_prez;
        dbms_output.put_line('Valoarea totala a veniturilor lunare este de ' || val_lun || ' unitati monetare, iar cea medie este de ' || val_med || ' unitati monetare.');
        dbms_output.new_line();
        close curs_ang;
    end loop;
    close curs_jobs;
    select avg(salary), sum(salary), count(employee_id)
    into val_med, val_lun, nr_ang
    from employees;
    dbms_output.put_line('In total sunt ' || nr_ang || ' angajati, avand un venit total de ' || val_lun || ' unitati monetare, iar unul mediu de ' || val_med || ' unitati monetare');
END;
/

--3.
DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name, salary, commission_pct
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb;
    ang_curent varchar(30);
    job_prez jobs.job_title%type;
    val_lun number;
    val_med number;
    nr_ang number;
    val_comision number;
    val_totala number;
    cms_curent number;
    salariu_curent number;
BEGIN
    val_totala := 0;
    open curs_jobs;
    loop
        fetch curs_jobs into job_prez;
        exit when curs_jobs%notfound;
        open curs_ang(job_prez);
        loop
            fetch curs_ang into ang_curent, salariu_curent, cms_curent;
            exit when curs_ang%notfound;
            val_totala := val_totala + salariu_curent + nvl(cms_curent, 0)*salariu_curent;
        end loop;
        close curs_ang;
    end loop;
    close curs_jobs;
    dbms_output.put_line('In total sunt alocate ' || val_totala || ' unitati monetare lunar pentru salarii si comisioane');
    dbms_output.new_line();
    for i in (select last_name || ' ' || first_name nume, salary sal, commission_pct cms from employees) loop
        val_lun := i.sal + nvl(i.cms, 0) * i.sal;
        dbms_output.put_line('Angajatul ' || i.nume || ' primeste un procent de ' || val_lun * 100/val_totala || ' din totalul lunar.');
    end loop;
END;
/


--4.
DECLARE
    cursor curs_jobs is
        select job_title 
        from jobs;
    cursor curs_ang(jobb jobs.job_title%type) is
        select last_name || ' ' || first_name, salary
        from employees e join jobs j on e.job_id = j.job_id
        where job_title = jobb
        order by salary desc;
    ang_curent varchar(30);
    job_prez jobs.job_title%type;
    sal_curent number;
BEGIN
    open curs_jobs;
    loop
        fetch curs_jobs into job_prez;
        exit when curs_jobs%notfound;
        open curs_ang(job_prez);
        dbms_output.put_line('Pentru jobul ' || job_prez || ' angajatii sunt:' );
        loop
            fetch curs_ang into ang_curent, sal_curent;
            exit when curs_ang%notfound or curs_ang%rowcount > 5;
            dbms_output.put_line(ang_curent || ' cu salariul ' || sal_curent);
        end loop;
        if (curs_ang%rowcount < 5) then
            dbms_output.put_line('Sunt mai putin de 5 angajati la acest job!');
        end if;
        dbms_output.new_line();
        close curs_ang;
    end loop;
    close curs_jobs;
END;
/
