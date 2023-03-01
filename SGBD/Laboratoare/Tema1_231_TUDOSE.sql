--8.
select case
        when (select count(*) from reservation res join rental ren on res.title_id = ren.title_id where book_date = res_date) = (select count(*) from reservation) then 'da'
        else 'nu'
        end
from dual;
        
--9.
select m.last_name || ' ' || m.first_name "nume si prenume", t.title, count(*)
from member m, title t, rental r
where m.member_id = r.member_id and t.title_id = r.title_id
group by m.last_name, m.first_name, t.title;
