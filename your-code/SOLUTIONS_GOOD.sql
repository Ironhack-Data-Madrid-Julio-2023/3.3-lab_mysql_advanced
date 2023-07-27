use publications;
--------------------------------------------------------------------------------
#CHALLENGE 1:
	#STEP_1
SELECT t.title_id, a.au_id, CONCAT('los royaltys por autor y titulo: ', t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100)
FROM authors AS a, roysched AS r, titles AS t, sales AS s, titleauthor AS ta
WHERE t.title_id = s.title_id AND r.title_id = s.title_id AND t.title_id = ta.title_id AND ta.au_id = a.au_id;
-------------------------------------------------------------------------------------------
#CHALLENGE 1:
	#STEP_2
SELECT t.title_id, a.au_id, CONCAT('los royaltys por autor y titulo: ', t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'REVENUE'
FROM authors AS a, roysched AS r, titles AS t, sales AS s, titleauthor AS ta
WHERE t.title_id = s.title_id AND r.title_id = s.title_id AND t.title_id = ta.title_id AND ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id,s.qty;
-------------------------------------------------------
#CHALLENGE 2:
	#STEP_3
SELECT t.title_id, a.au_id, CONCAT('los royaltys por autor y titulo: ', t.price+t.advance* s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'PROFITS'
FROM authors AS a, roysched AS r, titles AS t, sales AS s, titleauthor AS ta
WHERE t.title_id = s.title_id AND r.title_id = s.title_id AND t.title_id = ta.title_id AND ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id,s.qty
order by CONCAT('los royaltys por autor y titulo: ', t.price+t.advance* s.qty * t.royalty / 100 * ta.royaltyper / 100) desc
limit 3;
---------------------------------------------------------------
drop  TEMPORARY table temporal;
create TEMPORARY table temporal (
titulo_id varchar(20),
autor_id varchar (39),
profits varchar (60)
);
-------------------------------------
insert into temporal (titulo_id, autor_id, profits)
SELECT t.title_id, a.au_id, CONCAT('los royaltys por autor y titulo: ', t.price+t.advance* s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'PROFITS'
FROM authors AS a, roysched AS r, titles AS t, sales AS s, titleauthor AS ta
WHERE t.title_id = s.title_id AND r.title_id = s.title_id AND t.title_id = ta.title_id AND ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id,s.qty;
---------------------------------------
select*from temporal;

-----------------------------------------------

#CHALLENGE 3:
	#STEP_3
DROP TABLE most_profiting_authors;
create table most_profiting_authors (
autor_id varchar (39),
profits varchar (60)
);

insert into most_profiting_authors (autor_id, profits)
SELECT a.au_id, CONCAT('los royaltys por autor y titulo: ', t.price+t.advance* s.qty * t.royalty / 100 * ta.royaltyper / 100) as 'PROFITS'
FROM authors AS a, roysched AS r, titles AS t, sales AS s, titleauthor AS ta
WHERE t.title_id = s.title_id AND r.title_id = s.title_id AND t.title_id = ta.title_id AND ta.au_id = a.au_id
GROUP BY t.title_id, a.au_id,s.qty
order by CONCAT('los royaltys por autor y titulo: ', t.price+t.advance* s.qty * t.royalty / 100 * ta.royaltyper / 100) desc
limit 3;

select*from most_profiting_authors


