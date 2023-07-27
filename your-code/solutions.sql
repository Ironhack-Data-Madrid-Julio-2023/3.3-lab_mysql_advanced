-- Challenge 1

-- Step 1

select 
titles.title_id as 'TITLE ID',
titleauthor.au_id as 'AUTHOR ID',
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty

from titles

join sales on titles.title_id = sales.title_id
join titleauthor on titles.title_id = titleauthor.title_id;

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
    subquery.author_id AS 'AUTHOR ID',
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

create temporary table tabla_temporal as

SELECT
    subquery.author_id AS 'AUTHOR ID',
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

-- Challenge 3

create table most_profiting_authors  as
SELECT
    subquery.author_id AS 'AUTHOR ID',
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