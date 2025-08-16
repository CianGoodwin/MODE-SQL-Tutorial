------------------------------------------------------------
-- Question 1:
-- Write a query to count the number of non-null rows in the low column.
------------------------------------------------------------

SELECT COUNT(low)
  FROM tutorial.aapl_historical_stock_price
  

------------------------------------------------------------
-- Question 2:
-- Write a query that determines counts of every single column. With these counts, can you tell which column has the most null values?
------------------------------------------------------------

SELECT COUNT(date) AS date,
       COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT("open") AS "open",
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT("close") AS "close",
       COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price

------------------------------------------------------------
-- Question 3:
-- Write a query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).
------------------------------------------------------------

SELECT SUM("open")/COUNT("open") AS "Average open price"
  FROM tutorial.aapl_historical_stock_price
  
------------------------------------------------------------
-- Question 4:
-- What was Apple's lowest stock price (at the time of this data collection)?
------------------------------------------------------------

SELECT MIN(low) AS min_low
  FROM tutorial.aapl_historical_stock_price
 
------------------------------------------------------------
-- Question 5:
-- What was the highest single-day increase in Apple's share value?
------------------------------------------------------------

SELECT MAX("close" - "open") AS "Biggest increase"
  FROM tutorial.aapl_historical_stock_price
  
------------------------------------------------------------
-- Question 6:
-- Write a query that calculates the average daily trade volume for Apple stock.
------------------------------------------------------------

SELECT AVG(volume)
  FROM tutorial.aapl_historical_stock_price
  
------------------------------------------------------------
-- Question 7:
-- Calculate the total number of shares traded each month. Order your results chronologically.
------------------------------------------------------------

SELECT year,
       month,
       SUM("volume") AS "Total shares"
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year, month
  
------------------------------------------------------------
-- Question 8:
-- Write a query to calculate the average daily price change in Apple stock, grouped by year.
------------------------------------------------------------

SELECT year,
       AVG("close" - "open") AS "average_change"
    FROM tutorial.aapl_historical_stock_price
  GROUP BY year
  ORDER BY year
   
------------------------------------------------------------
-- Question 9:
-- Write a query that calculates the lowest and highest prices that Apple stock achieved each month.
------------------------------------------------------------

SELECT year,
       month,
       MIN(low) AS low,
       MAX(high) AS high
   FROM tutorial.aapl_historical_stock_price
  GROUP BY year, month
  ORDER BY year, month
  
------------------------------------------------------------
-- Question 10:
-- Write a query that includes a column that is flagged "yes" when a player is from California, and sort the results with those players first.
------------------------------------------------------------

SELECT player_name,
       state,
       CASE WHEN "state" = 'CA' THEN 'yes'
            ELSE NULL END AS "From California"
   FROM benn.college_football_players
  ORDER BY "From California"
  
------------------------------------------------------------
-- Question 11:
-- Write a query that includes players' names and a column that classifies them into four categories based on height. Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights in many ways.
------------------------------------------------------------

SELECT player_name,
       height,
       CASE WHEN height >= 80 THEN '>80'
            WHEN height BETWEEN 75 AND 79 THEN '75 - 79'
            WHEN height BETWEEN 70 AND 74 THEN '70 - 74'
            ELSE '<70' END AS "height_group"
   FROM benn.college_football_players
  
------------------------------------------------------------
-- Question 12:
-- Write a query that selects all columns from benn.college_football_players and adds an additional column that displays the player's name if that player is a junior or senior.
------------------------------------------------------------

SELECT *,
       CASE WHEN "year" = 'JR' OR "year" = 'SR' THEN player_name
       ELSE NULL END AS "junior_or_senior"
   FROM benn.college_football_players
  
------------------------------------------------------------
-- Question 13:
-- Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (everywhere else).
------------------------------------------------------------

SELECT CASE WHEN "state" IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN "state" = 'TX' THEN 'Texas'
            ELSE 'other' END AS "WestCoast_or_Texas",
      COUNT(1) AS "Count"
   FROM benn.college_football_players
  WHERE weight >= 300
  GROUP BY "WestCoast_or_Texas"
 
------------------------------------------------------------
-- Question 14:
-- Write a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California.
------------------------------------------------------------

SELECT CASE WHEN "year" IN ('FR','SO') THEN 'Underclass'
            WHEN "year" IN ('JR','SR') THEN 'Upperclass'
            ELSE NULL END AS "Class",
       SUM(weight) AS "Combined Weight"
   FROM benn.college_football_players
  WHERE state = 'CA'
   GROUP BY "Class"
 
------------------------------------------------------------
-- Question 15:
-- Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.
------------------------------------------------------------

SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(*) AS "Total"
   FROM benn.college_football_players
  GROUP BY state
   ORDER BY "Total" DESC
 
------------------------------------------------------------
-- Question 16
-- Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
------------------------------------------------------------

SELECT CASE WHEN "school_name" < 'n' THEN 'A - M'
            ELSE 'N - Z' END AS "First letter of school name",
        COUNT(1)
   FROM benn.college_football_players
  GROUP BY 1
  
------------------------------------------------------------
-- Question 17:
-- Write a query that returns the unique values in the year column, in chronological order.
------------------------------------------------------------

SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
  ORDER BY year 
    
------------------------------------------------------------
-- Question 18:
-- Write a query that counts the number of unique values in the month column for each year.
------------------------------------------------------------

SELECT year,
       COUNT(DISTINCT month) AS "Number of months"
   FROM tutorial.aapl_historical_stock_price
  GROUP BY year
    
------------------------------------------------------------
-- Question 19:
-- Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.
------------------------------------------------------------

SELECT COUNT(DISTINCT year) AS "Number of years",
       COUNT(DISTINCT month) AS "Number of Months"
   FROM tutorial.aapl_historical_stock_price

------------------------------------------------------------
-- Question 20:
-- Write a query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names in relation to the alias.
------------------------------------------------------------

SELECT player.school_name,
       player.player_name,
       player.position,
       player.weight
   FROM benn.college_football_players player
  WHERE player.state = 'GA'
  ORDER BY player.weight DESC
    
------------------------------------------------------------
-- Question 21:
-- Write a query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
------------------------------------------------------------

SELECT teams.conference AS "conference",
       teams.school_name,
       players.player_name
   FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
  ON players.school_name = teams.school_name
  WHERE teams.division = 'FBS (Division I-A Teams)'
    
------------------------------------------------------------
-- Question 22:
-- Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.
------------------------------------------------------------

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(aquisitions.company_permalink) AS aquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions aquisitions
   ON companies.permalink = aquisitions.company_permalink
    
------------------------------------------------------------
-- Question 23:
-- Modify the query above to be a LEFT JOIN. Note the difference in results.
------------------------------------------------------------

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(aquisitions.company_permalink) AS aquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions aquisitions
   ON companies.permalink = aquisitions.company_permalink
  
------------------------------------------------------------
-- Question 24:
-- Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.
------------------------------------------------------------

SELECT companies.state_code AS "state",
       COUNT(DISTINCT companies.name) AS unique_company_count,
       COUNT(DISTINCT aquisitions.company_name) AS unique_aquisitions_count
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions aquisitions
    ON companies.permalink = aquisitions.company_permalink
  WHERE companies.state_code IS NOT NULL
  GROUP BY 1
  ORDER BY 3 DESC
  
------------------------------------------------------------
-- Question 25:
-- Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.
------------------------------------------------------------

SELECT companies.state_code,
       COUNT(DISTINCT companies.name) AS number_of_companies,
       COUNT(DISTINCT acquired.company_name) AS numer_acquired
  FROM tutorial.crunchbase_acquisitions acquired
  RIGHT JOIN tutorial.crunchbase_companies companies
    ON acquired.company_permalink = companies.permalink 
  WHERE companies.state_code IS NOT NULL
  GROUP BY 1
  ORDER BY 3 DESC

------------------------------------------------------------
-- Question 26:
-- Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York.
------------------------------------------------------------

SELECT companies.name,
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS unique_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
    AND companies.state_code = 'NY'
  GROUP BY name, status
  ORDER BY 3 DESC

------------------------------------------------------------
-- Question 27:
-- Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York.
------------------------------------------------------------

SELECT CASE WHEN investments.investor_name IS NULL THEN 'No Investor'
            ELSE investments.investor_name END AS "Investor",
       COUNT(DISTINCT investments.company_name) AS number_of_companies_invested_in
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink 
  GROUP BY 1
  ORDER BY 2 DESC

------------------------------------------------------------
-- Question 28:
-- Write a query that lists investors based on the number of companies in which they are invested. Include a row for companies with no investor, and order from most companies to least.
------------------------------------------------------------

SELECT COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NULL 
                  THEN companies.permalink ELSE NULL END) AS "companies_only",
       COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NOT NULL 
                  THEN companies.permalink ELSE NULL END) AS "both",
       COUNT(CASE WHEN companies.permalink IS NULL AND investments.company_permalink IS NOT NULL 
                  THEN investments.company_permalink ELSE NULL END) AS "investments_only"
  FROM tutorial.crunchbase_companies companies
  FULL JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink

------------------------------------------------------------
-- Question 29:
-- Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. Count up the number of rows that are matched/unmatched as in the example above.
------------------------------------------------------------

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part1
  WHERE company_name ILIKE 'T%'
  
  
UNION ALL 


SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part2
  WHERE company_name ILIKE 'M%'

------------------------------------------------------------
-- Question 30:
-- Write a query that appends the two crunchbase_investments datasets above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M" (both not case-sensitive). Only include the company_permalink, company_name, and investor_name columns.
------------------------------------------------------------

SELECT 1 AS "dataset",
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS "distinct_investors"
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
  GROUP BY status

UNION ALL 

SELECT 2 AS "dataset",
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS "distinct_investors"
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
  GROUP BY status
