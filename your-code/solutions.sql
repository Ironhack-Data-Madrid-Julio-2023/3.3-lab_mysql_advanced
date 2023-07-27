-- CHALLLENGE # 1 - Most Profiting Authors
SELECT
    t.royalty AS 'Royalty',
    ta.royaltyper AS 'Royalty Percentage'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id;

SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS 'Sales Royalty'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    sales s ON ta.title_id = s.title_id;
    
    SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    t.price AS 'Title Price',
    s.qty AS 'Sales Quantity',
    t.royalty AS 'Title Royalty',
    ta.royaltyper AS 'Author Royalty Percentage'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    sales s ON ta.title_id = s.title_id;
    
CREATE TEMPORARY TABLE temp_salesroyalty AS
SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS 'Sales Royalty'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    sales s ON ta.title_id = s.title_id;
    
    SELECT * from temp_salesroyalty;
    SELECT
    `Title ID`,
    `Author ID`,
    SUM(`Sales Royalty`) AS 'Total Sales Royalty'
FROM
    temp_salesroyalty
GROUP BY
    `Title ID`, `Author ID`;
    
    CREATE TEMPORARY TABLE temp_Totalsalesroyalty AS
    SELECT
    `Title ID`,
    `Author ID`,
    SUM(`Sales Royalty`) AS 'Total Sales Royalty'
		FROM
			temp_salesroyalty
		GROUP BY
			`Title ID`, `Author ID`;
            
            SELECT * FROM  temp_Totalsalesroyalty;
            
	SELECT
    ta.au_id AS 'Author ID',
    SUM(tt.`Total Sales Royalty` + t.advance) AS 'Profit'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    temp_Totalsalesroyalty tt ON ta.title_id = tt.`Title ID`
GROUP BY
	ta.au_id, ta.title_id;
    
    SELECT
    ta.au_id AS 'Author ID',
    SUM(tt.`Total Sales Royalty` + t.advance) AS 'Profit'
FROM
    titleauthor ta
JOIN
    titles t ON ta.title_id = t.title_id
JOIN
    temp_Totalsalesroyalty tt ON ta.title_id = tt.`Title ID`
GROUP BY
    ta.au_id, ta.title_id
ORDER BY
    `Profit` DESC
LIMIT 3;

-- CHALLENGE # 2 - Alternative Solution

SELECT
    t.royalty AS 'Royalty',
    ta.royaltyper AS 'Royalty Percentage'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id;

SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS 'Sales Royalty'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id
JOIN
    (SELECT *
    FROM sales) s ON ta.title_id = s.title_id;
    
 SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    t.price AS 'Title Price',
    s.qty AS 'Sales Quantity',
    t.royalty AS 'Title Royalty',
    ta.royaltyper AS 'Author Royalty Percentage'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id
JOIN
    (SELECT *
    FROM sales) s ON ta.title_id = s.title_id;

SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    (t.price * s.qty * t.royalty * ta.royaltyper / 10000) AS 'Sales Royalty'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id
JOIN
    (SELECT *
    FROM sales) s ON ta.title_id = s.title_id;
    
    SELECT
    ta.title_id AS 'Title ID',
    ta.au_id AS 'Author ID',
    t.price AS 'Title Price',
    s.qty AS 'Sales Quantity',
    t.royalty AS 'Title Royalty',
    ta.royaltyper AS 'Author Royalty Percentage'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id
JOIN
    (SELECT *
    FROM sales) s ON ta.title_id = s.title_id;

SELECT
    `Title ID`,
    `Author ID`,
    SUM(`Sales Royalty`) AS 'Total Sales Royalty'
FROM
    (SELECT *
    FROM temp_salesroyalty) AS temp_salesroyalty
GROUP BY
    `Title ID`, `Author ID`;
SELECT
    `Title ID`,
    `Author ID`,
    SUM(`Sales Royalty`) AS 'Total Sales Royalty'
FROM
    (SELECT *
    FROM temp_salesroyalty) AS temp_salesroyalty
GROUP BY
    `Title ID`, `Author ID`;
    SELECT
    ta.au_id AS 'Author ID',
    SUM(tt.`Total Sales Royalty` + t.advance) AS 'Profit'
FROM
    (SELECT *
    FROM titleauthor) ta
JOIN
    (SELECT *
    FROM titles) t ON ta.title_id = t.title_id
JOIN
    (SELECT *
    FROM temp_Totalsalesroyalty) tt ON ta.title_id = tt.`Title ID`
GROUP BY
    ta.au_id, ta.title_id
ORDER BY
    `Profit` DESC
LIMIT 3;
    