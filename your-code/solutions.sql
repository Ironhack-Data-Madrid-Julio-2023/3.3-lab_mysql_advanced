-- Challenge 1

select  a.au_id, au_lname, au_fname, t.title_id, t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 as sales_royalty
from titleauthor as ta
left join titles as t
on t.title_id = ta.title_id
left join authors as a
on a.au_id = ta.au_id
left join publishers as p
on p.pub_id = t.pub_id
left join sales as s
on s.title_id = ta.title_id

-- Challenge 2

select  a.au_id, t.title_id, 
sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty
from titleauthor as ta
left join titles as t
on t.title_id = ta.title_id
left join authors as a
on a.au_id = ta.au_id
left join publishers as p
on p.pub_id = t.pub_id
left join sales as s
on s.title_id = ta.title_id

group by t.title_id, a.au_id

order by sales_royalty desc
limit 3;

-- Challenge 3

select  a.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance) as profits
from titleauthor as ta
left join titles as t
on t.title_id = ta.title_id
left join authors as a
on a.au_id = ta.au_id
left join publishers as p
on p.pub_id = t.pub_id
left join sales as s
on s.title_id = ta.title_id

group by a.au_id

order by profits desc
limit 3;

-- Challenge 4

create temporary table authors_profit

select  a.au_id, sum(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100 + t.advance) as profits
from titleauthor as ta
left join titles as t
on t.title_id = ta.title_id
left join authors as a
on a.au_id = ta.au_id
left join publishers as p
on p.pub_id = t.pub_id
left join sales as s
on s.title_id = ta.title_id

group by a.au_id

-- Change 5

create table profits_au as
select * from authors_profit