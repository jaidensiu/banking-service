## Docker

Docker is a platform that enables developers to build, deploy, and run applications inside containers. Containers are lightweight, portable, and self-sufficient units that include everything needed to run an application, such as code, runtime, libraries, and system tools.

Docker images are read-only templates that contain the instructions to create a Docker container. They are a snapshot or blueprint of the libraries, dependencies, and application code required inside a container. Images are used to build containers. They can be pulled from Docker Hub or other container registries, or built from a Dockerfile.

A Docker container is a lightweight, standalone, executable package of software that includes everything needed to run an application. Containers are instances of Docker images. Containers run in isolation from each other and the host system, ensuring that applications run consistently regardless of the environment. Containers are portable meaning that they can be easily moved between different environments, such as development, testing, and production. We can think of a container as an instance of the application contained in the image.

Dockerfiles are text files that contain a series of instructions on how to build a Docker image. They specify the base image, application code, dependencies, and commands to run.

Docker Hub is a cloud-based registry service where Docker images can be stored, shared, and managed. It provides access to a vast library of pre-built images.

Docker Compose is a tool for defining and running multi-container Docker applications. It uses a YAML file to configure the application's services, networks, and volumes.

Here is the [Docker CLI cheat sheet](https://docs.docker.com/get-started/docker_cheatsheet.pdf).

## Database migrations

Database migrations manage and version control changes to a database schema over time. They enable developers to apply incremental changes to the database structure in a controlled and consistent manner. Migrations are tracked in a migration table, which records executed migrations to ensure each migration is applied only once and in the correct order.

Some use cases for database migrations include:
- Version control: migrations provide a history of changes made to the database schema useful for documenting incremental changes
- Consistency across environments: migrations ensure that the database schema is consistent across development, testing, staging, and production environments
- Automated deployments: migrations can be integrated into a deployment pipeline to allow for schema changes which can reduce human errors and esure that the database is always in sync with the application code
- Rollback capability: migrations often include the ability to roll back changes to provide a safety net in case a migration introduces issues which allows for quick recoveries and minizes downtime

Up migrations apply changes to the database schema such as adding new tables, columns, indexes, or other schema changes. When an up migration is applied, the up migration script is executed and makes the necessary changes to the database schema. The migration is then marked as applied in the migration table tracking.

Down migrations roll back changes by executing the down migration script. This script reverts the changes made by the up migration, and then marks as not applied in the migration tracking table.

## Database CRUD operations

CRUD stands for Create, Read, Update, and Delete. These are the four basic operations that can be performed on data in a database or a similar data storage system.

1. Create: adding new records to the database
2. Read: retrieving existing records from the database
3. Update: modifying existing records in the database
4. Delete: removing existing records from the database

To perform CRUD operations, you can use raw SQL queries or an ORM (Object-Relational Mapping) library. Raw SQL refers to writing and executing SQL (Structured Query Language) queries directly against a database without any abstraction or intermediary layer. An ORM library simplifies database interactions by mapping database tables to classes in your programming language.

Pros of SQL:
- Performance: raw SQL can be more performant as it allows for fine-tuned queries
- Flexibility: you have complete control over the SQL queries, allowing for complex and optimized queries
- Database-Specific Features: you can leverage database-specific features and optimizations

Cons of SQL:
- Boilerplate code: requires writing a lot of repetitive code for common operations
- Error-prone: more prone to SQL injection attacks if not handled properly
- Maintenance: harder to maintain and refactor, especially for large projects

Pros of ORM libraries:
- Productivity: simplifies database operations, reducing the amount of boilerplate code
- Abstraction: provides a higher level of abstraction, making it easier to work with complex data models
- Security: automatically handles SQL injection prevention
- Portability: easier to switch between different database systems

Cons of ORM libraries:
- Performance overhead: may introduce performance overhead due to abstraction layers
- Learning curve: requires learning the ORM's API and conventions
- Less control: less control over the exact SQL queries being executed, which can be a drawback for complex queries

## Database transactions

A database transaction is a sequence of one or more SQL operations executed as a single unit of work. Transactions ensure that a series of operations either complete entirely or have no effect at all, maintaining the integrity and consistency of the database.

Transactions are characterized by the ACID properties:
- Atomicity: ensures that all operations within a transaction are completed successfully; if any operation fails, the entire transaction is rolled back, leaving the database in its original state
- Consistency: ensures that a transaction brings the database from one valid state to another, maintaining database invariants
- Isolation: ensures that the operations of a transaction are isolated from other transactions; intermediate states of a transaction are not visible to other transactions
- Durability: ensures that once a transaction is committed, its changes are permanent, even in the case of a system failure

Transaction lifecycle:
- Begin: the transaction starts
- Execute: SQL operations are executed
- Commit: if all operations are successful, the transaction is committed, making all changes permanent
- Rollback: if any operation fails, the transaction is rolled back, undoing all changes made during the transaction

In SQL, use can use comands like `BEGIN`, `COMMIT`, and `ROLLBACK` to implement transactions. Here's an example:

```sql
BEGIN;

UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;

COMMIT;
```

Read phenomena are types of data anomalies that can occur when transactions are executed concurrently. They include:

1. Dirty reads
- Occurs when a transaction reads data that has been updated by another transaction that is not yet committed
- Example: `Transaction A` updates a row, and `Transaction B` reads that row before `Transaction A` commits or rolls back

2. Non-repeatable reads
- Occurs when a transaction retrieves a row twice and that row is updated by another transaction that is committed in between
- Example: `Transaction A` reads a row, `Transaction B` updates and commits the row, and then `Transaction A` reads the same row again and sees the updated value

3. Phatom reads
- Occurs when a transaction retrieves a set of rows twice and new rows are inserted into or removed from that set by another transaction that is committed in between
- Example: `Transaction A` reads rows where `age > 30`, `Transaction B` inserts a new row with `age = 35` and commits, and then `Transaction A` re-executes the query and sees the new row

Isolation levels define the degree to which the operations in one transaction are isolated from those in other concurrent transactions. They help manage concurrency and ensure data consistency. The ANSI (American National Standards Institute) SQL standard defines 4 isolation levels from highest to lowest:

1. Serializable
- The highest isolation level, ensuring complete isolation from other transactions, effectively serializing them
- Pros: prevents dirty reads, non-repeatable reads, and phantom reads
- Cons: lowest concurrency, highest isolation
- Use case: used when absolute consistency is required

2. Repeatable read
- Ensures that if a transaction reads a value, it will see the same value if it reads it again, even if other transactions modify it
- Pros: prevents dirty reads and non-repeatable reads
- Cons: can still lead to phantom reads
- Use cases: suitable for scenarios where consistent reads are crucial

3. Read committed
- Transactions can only see changes made by other committed transactions
- Pros: prevents dirty reads
- Cons: can still lead to non-repeatable reads and phantom reads
- Use cases: commonly used as a default isolation level in many databases

4. Read uncommitted
- Transactions can see uncommitted changes made by other transactions
- Pros: highest concurrency, lowest isolation
- Cons: can lead to dirty reads, non-repeatable reads, and phantom reads
- Use cases: rarely used due to high risk of data anomalies

Table of isolation levels vs read phenomena:

| Isolation Level   | Dirty Read | Non-Repeatable Read | Phantom Read |
|-------------------|------------|---------------------|--------------|
| Serializable      | No         | No                  | No           |
| Repeatable Read   | No         | No                  | Yes          |
| Read Committed    | No         | Yes                 | Yes          |
| Read Uncommitted  | Yes        | Yes                 | Yes          |

Higher isolation levels provide stronger guarantees of data consistency but may reduce concurrency and increase the potential for transaction conflicts.

Different RDBMS support different isolation levels based on their design goals, performance optimizations, and user requirements. Understanding the isolation levels supported by your chosen RDBMS and their implications can help you design robust and efficient database applications.

## What is a middleware?

A middleware is a function that intercepts and processes requests before they reach the main handler in a web application. When a client sends a request to a specific API route on the server, the request will first pass through one or more middleware functions (such as logging or authentication middleware).

For an authentication middleware, we can:

1. Parse and check if the access token is valid.
2. If the token is invalid or expired, abort the request and send a 401 status to the client.
3. If the token is valid, store the parsed token payload in the context and forward the request to the next middleware or handler.

The handler will then read the token payload to identify the user and determine what actions they are authorized to perform and what data can be returned to the client.
