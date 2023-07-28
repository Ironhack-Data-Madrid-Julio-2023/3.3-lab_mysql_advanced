-- CHALLENGE 1.1

select ta.au_id as author_id, t.title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty

from 
authors as a
left join 
titleauthor as ta
on a.au_id = ta.au_id
left join
titles as t
on t.title_id = ta.title_id
left join
sales as s
on s.title_id = t.title_id

-- CHALLENGE 1.2/1.3
select subquery1.author_id, sum(t.advance) + sum(subquery1.sales_royalty) as total_royalty
from
(select ta.au_id as author_id, t.title_id as title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
from 
authors as a
left join 
titleauthor as ta
on a.au_id = ta.au_id
left join
titles as t
on t.title_id = ta.title_id
left join
sales as s
on s.title_id = t.title_id) as subquery1
left join 
titles as t
on t.title_id = subquery1.title_id
group by subquery1.author_id
order by total_royalty desc
limit 3

-- CHALLENGE 2

create temporary table publications.total_royalty
select subquery1.author_id, sum(t.advance) + sum(subquery1.sales_royalty) as total_royalty
from
(select ta.au_id as author_id, t.title_id as title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
from 
authors as a
left join 
titleauthor as ta
on a.au_id = ta.au_id
left join
titles as t
on t.title_id = ta.title_id
left join
sales as s
on s.title_id = t.title_id) as subquery1
left join 
titles as t
on t.title_id = subquery1.title_id
group by subquery1.author_id
order by total_royalty desc
limit 3

-- CHALLENGE 3

create table publications.most_profiting_authors
select subquery1.author_id, sum(t.advance) + sum(subquery1.sales_royalty) as total_royalty
from
(select ta.au_id as author_id, t.title_id as title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
from 
authors as a
left join 
titleauthor as ta
on a.au_id = ta.au_id
left join
titles as t
on t.title_id = ta.title_id
left join
sales as s
on s.title_id = t.title_id) as subquery1
left join 
titles as t
on t.title_id = subquery1.title_id
group by subquery1.author_id
order by total_royalty desc