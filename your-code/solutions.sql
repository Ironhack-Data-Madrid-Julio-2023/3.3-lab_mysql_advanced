Challenge 1
query 1

select a.au_id, t.title_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalties
from authors as a
left join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on t.title_id = ta.title_id
left join sales as s
on s.title_id = t.title_id
left join roysched as r
on r.title_id = t.title_id
group by s.qty,a.au_id, t.title_id, ta.royaltyper


query 2

select title_id, au_id, SUM(sales_royalties) AS sum_royalties
from    
(select a.au_id, t.title_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalties
from 
authors as a
left join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on t.title_id = ta.title_id
left join sales as s
on s.title_id = t.title_id
left join roysched as r
on r.title_id = t.title_id) as sub
group by a.au_id, t.title_id

query 3

SELECT
    sub.au_id AS 'Author ID', SUM(t.advance) + SUM(sub.sum_royalties) AS total_profits
from
(select sub.title_id, sub.au_id, SUM(sub.sales_royalties) AS sum_royalties
	from    
		(select a.au_id, t.title_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalties
		from 
		authors as a
		left join titleauthor as ta
			on ta.au_id = a.au_id
		left join titles as t
			on t.title_id = ta.title_id
		left join sales as s
			on s.title_id = t.title_id
		left join roysched as r
			on r.title_id = t.title_id) as sub
		group by sub.au_id, sub.title_id) as sub
			join titles as t 
				on t.title_id = sub.title_id
                group by sub.au_id
                order by total_profits DESC
                limit 3


Challenge 2
query 4

create temporary table tempo

SELECT
    sub.au_id AS 'Author ID', SUM(t.advance) + SUM(sub.sum_royalties) AS total_profits
 
from
(select sub.title_id, sub.au_id, SUM(sub.sales_royalties) AS sum_royalties
	from    
		(select a.au_id, t.title_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalties
		from 
		authors as a
		left join titleauthor as ta
			on ta.au_id = a.au_id
		left join titles as t
			on t.title_id = ta.title_id
		left join sales as s
			on s.title_id = t.title_id
		left join roysched as r
			on r.title_id = t.title_id) as sub
		group by sub.au_id, sub.title_id) as sub
			join titles as t 
				on t.title_id = sub.title_id
                group by sub.au_id
                order by total_profits DESC
                limit 3

Challenge 3
query 5

create table perma as

SELECT
    sub.au_id AS 'Author ID', SUM(t.advance) + SUM(sub.sum_royalties) AS total_profits
   
from
(select sub.title_id, sub.au_id, SUM(sub.sales_royalties) AS sum_royalties
	from    
		(select a.au_id, t.title_id, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalties
		from 
		authors as a
		left join titleauthor as ta
			on ta.au_id = a.au_id
		left join titles as t
			on t.title_id = ta.title_id
		left join sales as s
			on s.title_id = t.title_id
		left join roysched as r
			on r.title_id = t.title_id) as sub
		group by sub.au_id, sub.title_id) as sub
			join titles as t 
				on t.title_id = sub.title_id
                group by sub.au_id
                order by total_profits DESC
                limit 3