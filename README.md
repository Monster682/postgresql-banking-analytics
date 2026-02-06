# PostgreSQL Banking Analytics Project

Project Overview  
This project implements a production-oriented PostgreSQL analytics system for a retail banking use case.  
The focus is on performance, scalability, and maintainability, following real-world database engineering practices.

The system supports:
- Customer behaviour analysis
- High-volume transaction analytics
- Fraud pattern detection
- Loan default (NPA) risk analysis

Relationship to Reference Document  
This project is a practical implementation of core concepts from a broader banking analytics reference document.

- The reference document serves as a design blueprint.
- This project implements the most performance-critical and production-relevant components.
- Some advanced attributes and KPIs from the reference design are planned as future enhancements.

This reflects real industry practice where systems evolve iteratively.

Business Context  
Retail banking systems typically involve:
- Millions of transactions
- Frequent updates and status changes
- Time-based reporting requirements
- Strict performance SLAs

This project models these challenges using PostgreSQL with industry-grade optimization techniques.

Schema Overview  
Core tables:
- customers
- accounts
- transactions (high-volume, partitioned)
- loans
- loan_payments

The transactions table is the primary focus for performance optimization.

Key Design Decisions  

Table Partitioning  
- Partition Type: RANGE  
- Partition Column: txn_date  
- Granularity: Monthly  

sql
PARTITION BY RANGE (txn_date)
