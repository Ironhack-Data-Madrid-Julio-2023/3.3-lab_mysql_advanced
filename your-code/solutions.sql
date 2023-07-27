

SELECT 
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'TOTAL ROYALTIES'
FROM titles AS t
LEFT JOIN titleauthor AS ta ON t.title_id = ta.title_id
LEFT JOIN authors AS a ON a.au_id = ta.au_id
LEFT JOIN sales AS s ON s.title_id = ta.title_id; 


//

SELECT 
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'TOTAL ROYALTIES'
FROM titles AS t
LEFT JOIN titleauthor AS ta ON t.title_id = ta.title_id
LEFT JOIN authors AS a ON a.au_id = ta.au_id
LEFT JOIN sales AS s ON s.title_id = ta.title_id
GROUP BY t.title_id, ta.au_id;

//

SELECT
    author_id AS 'Author ID',
    SUM(advance + total_royalties) AS 'Profits'
FROM
    (
        SELECT
            ta.au_id AS author_id,
            SUM(t.advance) AS advance,
            SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS total_royalties
        FROM
            titles AS t
            LEFT JOIN titleauthor AS ta ON t.title_id = ta.title_id
            LEFT JOIN sales AS s ON s.title_id = ta.title_id
        GROUP BY
            ta.au_id, t.title_id
    ) AS subquery
GROUP BY
    author_id
ORDER BY
    'Profits' DESC
LIMIT 3;

//

CREATE TEMPORARY TABLE TOTALROYALTIES

SELECT 
    t.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS 'TOTAL ROYALTIES'
FROM titles AS t
LEFT JOIN titleauthor AS ta ON t.title_id = ta.title_id
LEFT JOIN authors AS a ON a.au_id = ta.au_id
LEFT JOIN sales AS s ON s.title_id = ta.title_id
GROUP BY t.title_id, ta.au_id;

//

CREATE TABLE most_profiting_authors (
    au_id VARCHAR(45) PRIMARY KEY,
    profits DECIMAL(10, 2)
);
INSERT INTO most_profiting_authors (au_id, profits)
SELECT
    author_id AS au_id,
    SUM(advance + total_royalties) AS profits
FROM
    (
        SELECT
            ta.au_id AS author_id,
            SUM(t.advance) AS advance,
            SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS total_royalties
        FROM
            titles AS t
            LEFT JOIN titleauthor AS ta ON t.title_id = ta.title_id
            LEFT JOIN sales AS s ON s.title_id = ta.title_id
        GROUP BY
            ta.au_id, t.title_id
    ) AS subquery
GROUP BY
    author_id
ORDER BY
    profits DESC
LIMIT 3;
