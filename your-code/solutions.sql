
/* Challenge 3 -------------------------------------------------------------------------------------------- */ 

select patata.author_id as author_id, sum(patata.profit) as total_profit 

from
(select a.au_id as author_id, t.title_id as title,
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance as profit

from authors as a
inner join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on ta.title_id = t.title_id
left join sales as s
on s.title_id = t.title_id
left join roysched as r
on s.title_id = r.title_id

group by a.au_id, ta.title_id) patata

group by patata.author_id;


/* Challenge 2 -------------------------------------------------------------------------------------------- */ 


create temporary table publications.patata
select a.au_id as author_id, t.title_id as title,
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) + t.advance as profit
from authors as a
inner join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on ta.title_id = t.title_id
left join sales as s
on s.title_id = t.title_id
left join roysched as r
on s.title_id = r.title_id
group by a.au_id, ta.title_id;

select p.author_id as author_id, sum(p.profit) as total_profit 
from publications.patata as p
group by p.author_id;


/* Challenge 3 -------------------------------------------------------------------------------------------- */

create table publications.most_profiting_authors
/*Contando con la tabla temporal creada arriba, si no habría que volver a crearla o utilizar derived tables como he hecho en challenge 1*/
select p.author_id as author_id, sum(p.profit) as total_profit 
from publications.patata as p
group by p.author_id;





