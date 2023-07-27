Step 1:

SELECT
    s.title_id,
    t.au_id as author_id,
    (ti.price * s.qty * ti.royalty / 100 * t.royaltyper / 100) as sales_royalty
    
FROM authors as a
LEFT JOIN titleauthor as t
ON a.au_id = t.au_id
INNER JOIN titles as ti
ON ti.title_id = t.title_id
INNER JOIN sales as s
ON s.title_id = ti.title_id

Step 2:

SELECT
    s.title_id,
    t.au_id,
    SUM(ti.price * s.qty * ti.royalty / 100 * t.royaltyper / 100) AS sales_royalty
    
    
FROM authors as a
LEFT JOIN titleauthor as t
ON a.au_id = t.au_id
INNER JOIN titles as ti
ON ti.title_id = t.title_id
INNER JOIN sales as s
ON s.title_id = ti.title_id
GROUP BY s.title_id, a.au_id


Step3:

SELECT
    a.au_id AS author_id,
    SUM((ti.price * s.qty * ti.royalty / 100 * t.royaltyper / 100) + advance) AS profit
    
FROM authors as a
LEFT JOIN titleauthor as t
ON a.au_id = t.au_id
INNER JOIN titles as ti
ON ti.title_id = t.title_id
INNER JOIN sales as s
ON s.title_id = ti.title_id
GROUP BY a.au_id
ORDER BY profit DESC LIMIT 3

Challenge #2

SELECT *
FROM author_profits
ORDER BY profit DESC

Challenge #3
CREATE TABLE author_profits AS
SELECT * FROM author_profits;
