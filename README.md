# 🎶 Music Store Data Analysis using SQL

A comprehensive data analysis project to extract business insights from a music store database, using SQL queries. This project explores various aspects like customer spending, popular music genres, high-earning artists, and top cities for sales, aimed at aiding business decision-making. 

---

## 📝 Project Overview

This project showcases **SQL querying techniques** for real-world data analysis on a music store database. The questions range from basic queries to more complex analyses, structured into three levels:
1. **Easy**: Basic data retrieval and ordering.
2. **Moderate**: Use of joins and filtering to refine data.
3. **Advanced**: Complex aggregations, Common Table Expressions (CTEs), and ranking functions.

Each question is addressed with a specific SQL query, providing actionable insights based on the data.

---

## 📊 Key Insights and Features

### 🟢 Easy Level
- **Identify Senior Employees**: Retrieved the most senior employee by job title.
- **Country with Most Sales**: Analyzed invoices to determine the country with the highest number of transactions.
- **Top Invoice Amounts**: Found the top 3 invoice amounts to identify significant sales.
- **Top Spending City**: Determined the city with the highest sum of invoice totals for targeted promotions.
- **Top Customer**: Identified the customer with the highest total spending.

### 🟡 Moderate Level
- **Rock Music Listeners**: Found customers who listened to rock music, ordered by email.
- **Top Rock Artists**: Identified the top 10 rock bands based on the number of tracks.
- **Longer Than Average Songs**: Listed all songs with lengths exceeding the average, ordered from longest to shortest.

### 🔴 Advanced Level
- **Top Spending on High-Earning Artist**: Identified customer spending for the artist with the highest earnings.
- **Most Popular Genre by Country**: Analyzed the top-selling genre in each country.
- **Top Customer by Country**: Found the highest-spending customer in each country.

---

## 🛠️ Tools & Technologies

- **Database Management**: SQL (Structured Query Language)
- **Database**: PostgreSQL
- **Concepts Used**:
  - Aggregate Functions (`SUM`, `COUNT`, `AVG`)
  - Joins (INNER JOIN, LEFT JOIN)
  - Common Table Expressions (CTEs)
  - Window Functions (`ROW_NUMBER`, `RANK`)
  - Subqueries
  - Filtering and Sorting (`WHERE`, `ORDER BY`, `GROUP BY`, `LIMIT`)

---

## 🚀 Getting Started

### Prerequisites
1. **Database**: This project is built on PostgreSQL, but can be adapted to other SQL databases with minor adjustments.
2. **Data Source**: Import the [Music Store Database](https://www.youtube.com/watch?v=VFIuIjswMKM&t=224s) from the link provided to set up the dataset.

### Steps to Run
1. **Clone this repository**:
   ```bash
   git clone https://github.com/your-username/Music-Store-SQL-Analysis.git
   cd Music-Store-SQL-Analysis
