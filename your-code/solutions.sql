EJERCICIO 1

select t.title_id, a.au_id, au_lname, au_fname,
t.price * s.qty * (t.royalty / 100) * (t_a.royaltyper / 100) as sale_royalty
from titles as t 
left join titleauthor as t_a on t.title_id = t_a.title_id
left join sales as s on t.title_id = s.title_id
left join authors as a on a.au_id = t_a.au_id
order by sale_royalty desc;


EJERCICIO 2

select title_id, au_id, au_fname, au_lname, sum(sale_royalty) as total_royalty
from 
(select t.title_id, a.au_id, au_lname, au_fname,
t.price * s.qty * (t.royalty / 100) * (t_a.royaltyper / 100) as sale_royalty
from titles as t 
left join titleauthor as t_a on t.title_id = t_a.title_id
left join sales as s on t.title_id = s.title_id
left join authors as a on a.au_id = t_a.au_id
order by sale_royalty desc) 
as royalties
GROUP BY royalties.au_id, royalties.title_id;

EJERCICIO 3

select au_id, sum(totals.total_royalty) as totalprofit
from 
(select title_id, au_id, au_fname, au_lname, sum(sale_royalty ) as total_royalty
from 
(select t.title_id, a.au_id, au_lname, au_fname,
t.price * s.qty * (t.royalty / 100) * (t_a.royaltyper / 100) + advance as sale_royalty
from titles as t 
left join titleauthor as t_a on t.title_id = t_a.title_id
left join sales as s on t.title_id = s.title_id
left join authors as a on a.au_id = t_a.au_id) 
as royalties
GROUP BY royalties.au_id, royalties.title_id)
as totals
group by au_id
order by totalprofit desc

EJERCICIO 4

create temporary table paso1
select title_id, au_id, au_fname, au_lname, sum(sale_royalty) as total_royalty
from 
(select t.title_id, a.au_id, au_lname, au_fname,
t.price * s.qty * (t.royalty / 100) * (t_a.royaltyper / 100) as sale_royalty
from titles as t 
left join titleauthor as t_a on t.title_id = t_a.title_id
left join sales as s on t.title_id = s.title_id
left join authors as a on a.au_id = t_a.au_id
order by sale_royalty desc) 
as royalties
GROUP BY royalties.au_id, royalties.title_id;


select au_id, sum(totals.total_royalty) as totalprofit
from paso1 as totals
group by au_id
order by totalprofit desc