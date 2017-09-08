# Workshop
SQL (Structured Query Language) is an old language, but it's everywhere and it's
not going away anytime soon. Feel free to search "Why Learn SQL?" and read until
you're convinced.

This workshop will walk students through the SQL language and how to interact
with data in and out of traditional development environments. No prior knowledge
of SQL is required, through it wouldn't hurt.

The minimum requirement is crude appreciation of tabular information like spreadsheets
or hand written tables. If the following table makes sense, then you're ready to
take the plunge into SQL.

| Thing    | Width | Height | Length |
|----------|-------|--------|--------|
| Book     | 1     | 6      | 4      |
| Box      | 5     | 5      | 5      |
| Building | 500   | 1000   | 500    |

## SQL Playground

### Connect to SQL Playground

Open a browser to https://sakila.dataturd.com. It will prompt you for a name.
Enter a somewhat unique name, otherwise you'll pick up someone else's session.
We'll be doing all our queries from this site so you may want to bookmark it.
Your data will be on the site until the next workshop so backup anything you'd
like to save in your personal notes.


### Sample Data

The sample data we'll be querying is named `sakila`. The `sakila` schema was
created MySQL and Oracle to represent an online DVD store. It contains many
tables normalized using industry standard practices. Data normalization
principles and strategies are out of scope for this workshop, but can be read in
depth at https://en.wikipedia.org/wiki/Database_normalization.

Due to the normalized nature of the Sakila schema, our initial queries will be
quite bland. Once we get into using joins, our results will interesting. Please
be patient.

<img src='http://database.guide/wp-content/uploads/2016/06/sakila_full_database_schema_diagram.png' alt="sakila schema diagram" />


## Anatomy of the `SELECT` Statement

<figure>
  <img src="http://www.sqlite.org/images/syntax/select-stmt.gif" alt="SELECT Statement" />
  <figcaption><a href="http://www.sqlite.org/lang_select.html">SELECT statement diagram provided by SQLite</a></figcaption>
</figure>

Oh my googly eyes! This map of possible keywords is menacing at first, but by
the of this session you'll be able to use these terms to compose interesting
results.

### SELECT .. FROM

Let's jump right and build out the first query.

1. Start a new query by selecting the `New Query` in the upper right corner.
2. Type the following text in the black box `SELECT * FROM country`.
3. Select `Run` or use the keyboard shortcut `Ctrl-Enter` on Windows/Linux or `⌘-Enter` on OSX.

The results of the query will display below query editor.

**Exercises**
1. List all actors.
2. List all films.
3. List all customers.

What does the `*` [star] character mean? `star` tell the database to return all the
columns of all the tables referenced in the `FROM` clause. `*` is great for
quickly seeing some results, but we shouldn't leave it there in our final
queries. It's best practise is to specify the exact columns desired from each
referenced table. To target specific terms replace `*` with `table_name.column_name`.

**Exercises**
1. List only first and last name from the actor table.
2. List only description from the film table.
3. List only email from customer table.

We just exercised the definition of `result-column` and the third option of the
`expr` grammar. We'll get back to more `expr` later in the workshop.

<figure>
  <img src="http://www.sqlite.org/images/syntax/result-column.gif" alt="result-column diagram" />
  <figcaption><a href="http://www.sqlite.org/lang_select.html">Diagram of `result-column`</a></figcaption>
</figure>

<figure>
  <img src="http://www.sqlite.org/images/syntax/expr.gif" alt="expr diagram" />
  <figcaption><a href="http://www.sqlite.org/syntax/expr.html">Diagram of `expr`</a></figcaption>
</figure>

### .. WHERE

1. List G rated films.

#### .. LIKE

1. List movies safe for teens (less than R)

2. List rentals between 5 and 10 dollars.

3. List addresses in the East Coast.

### .. ORDER BY [ASC | DESC] [LIMIT ..]

### .. LIMIT

### .. JOIN

This is how we relate from data from separate tables into a larger dataset.

1. List films with their language names.

2. List actors first and last name with their film.

3. List customers with their postal code.

#### INNER JOIN (default)

#### LEFT JOIN

1. List customers who don't have a rental.

2. List films without inventory.


#### FULL OUTER JOIN

1. Which category doesn't have a film and which film doesn't have a category?

### .. GROUP BY

#### Aggregate Functions

##### COUNT, SUM, AVG

https://www.postgresql.org/docs/9.3/static/functions-aggregate.html

#### .. HAVING

### .. UNION

### SELECT (SELECT .. ) FROM



## Functions

Functions are used to format or transform columns into something more desirable.

+ String Functions - https://www.postgresql.org/docs/9.3/static/functions-string.html
+ Math Functions - https://www.postgresql.org/docs/9.3/static/functions-math.html
+ Date Functions - https://www.postgresql.org/docs/9.3/static/functions-formatting.html
+ Misc - https://www.postgresql.org/docs/9.3/static/functions.html

### repeat()

Making a bar graph

### concat(), `||`

Make a full name



## Changing Data

### INSERT .. INTO

### DELETE .. FROM

### UPDATE .. SET



## Defining a Schema

https://www.postgresql.org/docs/9.3/static/ddl.html

### CREATE TABLE

### DROP TABLE


## Challenges


## Misc Notes

```sql
CREATE TABLE interests AS
  SELECT
    column1::int     AS id,
    column2::varchar AS name
  FROM (
    VALUES
      (1, 'Coding'),
      (2, 'Volleyball'),
      (3, 'Data'),
      (4, 'Teaching'),
      (5, 'Cooking'),
      (6, 'Ping Pong'),
      (7, 'Piano'),
      (8, 'Ramen'),
      (9, 'Pokemon'),
      (10, 'Potty jokes')
  ) AS t;

CREATE TABLE family_members AS
  SELECT
    column1::int AS id,
    column2::varchar AS name
  FROM (
    VALUES
      (1, 'Scott'),
      (2, 'Karen'),
      (3, 'Nathan'),
      (4, 'Morgan')
  ) AS t;

DROP TABLE family_members_interests;
CREATE TABLE family_members_interests AS
  SELECT
    column1::int AS member_id,
    column2::int AS interest_id
  FROM (
    VALUES
      (1, 1),
      (1, 2),
      (1, 3),
      (1, 4),
      (1, 6),
      (1, 7),
      (1, 8),
      (2, 6),
      (2, 7),
      (2, 8),
      (3, 8),
      (3, 9),
      (3, 10),
      (4, 10)
  ) AS t;

SELECT
    fm.name,
    string_agg(i.name, ', ') AS interests
FROM family_members fm
JOIN family_members_interests fmi
  ON fmi.member_id = fm.id
JOIN interests i
  ON i.id = fmi.interest_id
GROUP BY fm.id, fm.name
ORDER BY fm.id;
```
