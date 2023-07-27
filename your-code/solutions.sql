CHALLENGE 1

select subquery.au_id, sum(subquery.sales_royalty) as total_profits
from (select a.title_id,a.au_id,s.qty,(t.price * s.qty * t.royalty / 100 * a.royaltyper / 100)+t.advance as sales_royalty
from sales as s
left join roysched as r on s.title_id = r.title_id
left join titleauthor as a on s.title_id = a.title_id
left join titles as t on a.title_id = t.title_id

group by a.title_id,a.au_id,s.qty) AS subquery

group by subquery.au_id

ORDER BY
    total_profits DESC
LIMIT 3;



CHALLENGE 2

CREATE TEMPORARY TABLE sale_royalty_1 (
select a.title_id,a.au_id,s.qty,(t.price * s.qty * t.royalty / 100 * a.royaltyper / 100)+t.advance as sales_royalty
from sales as s
left join roysched as r on s.title_id = r.title_id
left join titleauthor as a on s.title_id = a.title_id
left join titles as t on a.title_id = t.title_id

group by a.title_id,a.au_id,s.qty
);

select sale_royalty_1.au_id, sum(sale_royalty_1.sales_royalty) as total_profits
from sale_royalty_1

group by sale_royalty_1.au_id

ORDER BY
    total_profits DESC
LIMIT 3;


CHALLENGE 3

select subquery.au_id, sum(subquery.sales_royalty) as total_profits
from (select a.title_id,a.au_id,s.qty,(t.price * s.qty * t.royalty / 100 * a.royaltyper / 100)+t.advance as sales_royalty
from sales as s
left join roysched as r on s.title_id = r.title_id
left join titleauthor as a on s.title_id = a.title_id
left join titles as t on a.title_id = t.title_id

group by a.title_id,a.au_id,s.qty) AS subquery

group by subquery.au_id

ORDER BY
    total_profits DESC
LIMIT 3;

create table most_profiting_authors as
select subquery.au_id, sum(subquery.sales_royalty) as total_profits
from (select a.title_id,a.au_id,s.qty,(t.price * s.qty * t.royalty / 100 * a.royaltyper / 100)+t.advance as sales_royalty
from sales as s
left join roysched as r on s.title_id = r.title_id
left join titleauthor as a on s.title_id = a.title_id
left join titles as t on a.title_id = t.title_id

group by a.title_id,a.au_id,s.qty) AS subquery

group by subquery.au_id

ORDER BY
    total_profits DESC
LIMIT 3;