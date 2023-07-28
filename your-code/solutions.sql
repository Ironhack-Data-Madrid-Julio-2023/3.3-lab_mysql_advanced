-- CHALLENGE 1
-- Step 1
SELECT
    titles.title_id AS 'Title ID',
    titleauthor.au_id AS 'Author ID',
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
    
FROM 
	titles
    
JOIN
	sales ON titles.title_id = sales.title_id

JOIN 
	titleauthor ON titles.title_id = titleauthor.title_id;
-- Step 2
SELECT
    subquery.title_id,
    subquery.author_id,
    SUM(subquery.sales_royalty) AS aggregated_royalties
FROM
    (
        SELECT
            titles.title_id,
            titleauthor.au_id AS author_id,
            titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
        FROM
            titles
        JOIN
            sales ON titles.title_id = sales.title_id
        JOIN
            titleauthor ON titles.title_id = titleauthor.title_id
    ) AS subquery
GROUP BY
    subquery.title_id,
    subquery.author_id;
-- Step 3
SELECT 
	subquery.author_id AS 'Author ID',
    SUM(titles.advance) + SUM(subquery.aggregated_royalties) AS total_profits

FROM 
	(
SELECT
    subquery.title_id,
    subquery.author_id,
    SUM(subquery.sales_royalty) AS aggregated_royalties
FROM
    (
        SELECT
            titles.title_id,
            titleauthor.au_id AS author_id,
            titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
        FROM
            titles
        JOIN
            sales ON titles.title_id = sales.title_id
        JOIN
            titleauthor ON titles.title_id = titleauthor.title_id
    ) AS subquery
GROUP BY
            subquery.title_id,
            subquery.author_id
    ) AS subquery
JOIN 
	titles ON subquery.title_id = titles.title_id

GROUP BY
    subquery.author_id
ORDER BY
    total_profits DESC
LIMIT 3;

-- Challenge 2
CREATE TEMPORARY TABLE temp_royalties AS
SELECT
    titles.title_id,
    titleauthor.au_id AS author_id,
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty
FROM
    titles
JOIN
    sales ON titles.title_id = sales.title_id
JOIN
    titleauthor ON titles.title_id = titleauthor.title_id;

CREATE TEMPORARY TABLE temp_aggregated_royalties AS
SELECT
    title_id,
    author_id,
    SUM(sales_royalty) AS aggregated_royalties
FROM
    temp_royalties
GROUP BY
    title_id,
    author_id;

-- Total profits/each author
SELECT
    author_id,
    SUM(titles.advance) + SUM(aggregated_royalties) AS total_profits
FROM
    temp_aggregated_royalties
JOIN
    titles ON temp_aggregated_royalties.title_id = titles.title_id
GROUP BY
    author_id
ORDER BY
    total_profits DESC
LIMIT 3;

-- Challenge 3
-- Step 1
CREATE TABLE most_profiting_authors (
    au_id VARCHAR(9) NOT NULL,
    profits DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (au_id)
);

-- Step 2
INSERT INTO most_profiting_authors (au_id, profits)
SELECT
    author_id,
    SUM(titles.advance) + SUM(aggregated_royalties) AS total_profits
FROM
    temp_aggregated_royalties
JOIN
    titles ON temp_aggregated_royalties.title_id = titles.title_id
GROUP BY
    author_id
ORDER BY
    total_profits DESC
LIMIT 3;

