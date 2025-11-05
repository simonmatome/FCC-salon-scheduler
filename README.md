# Salon Appointment Scheduler 
# (FreeCodeCamp Project)
This is a command-line interface (CLI) application built as a final project for the FreeCodeCamp Relational Database curriculum. The application simulates a real-world scheduling system for a salon, allowing users to browse services and book appointments directly from their terminal.

The primary goal of this project is to demonstrate proficiency in **Bash scripting** and **PostgreSQL**, showcasing the ability to build an interactive application that performs full CRUD (Create, Read, Update, Delete) operations on a relational database.

## Key Features
- Interactive Service Selection: Dynamically lists available salon services (e.g., cut, colour, perm) by querying the PostgreSQL database.
- **Customer Management**:
    - Recognises existing customers by their phone number.
    - Onboards new customers by requesting their name and phone number.
    - Persists all customer information in the customers table.
- **Appointment Booking**:
    - Guides the user through selecting a service and a preferred time.
    - Saves the appointment by linking customer_id and service_id in the appointments table.
- **Confirmation**: Provides a clear confirmation message to the user upon successful booking, summarising the service, time, and customer name.

## Stack
- **Scripting Language: Bash**
    - All application logic, user prompts, and interactivity are handled through a single salon.sh script.
- **Database: PostgreSQL (psql)**
    - Used for all data persistence, including managing services, customers, and appointments.
- **Environment**: Unix/Linux Shell

## Database Schema
The application relies on a normalised relational database with three main tables:

| Table         | Column         | Type    | Notes                                   |
|----------------|----------------|---------|------------------------------------------|
| **services**   | service_id     | SERIAL  | Primary Key                              |
|                | name           | VARCHAR |                                          |
| **customers**  | customer_id    | SERIAL  | Primary Key                              |
|                | phone          | VARCHAR | Unique                                   |
|                | name           | VARCHAR |                                          |
| **appointments** | appointment_id | SERIAL  | Primary Key                            |
|                | customer_id    | INT     | Foreign Key (references customers)       |
|                | service_id     | INT     | Foreign Key (references services)        |
|                | time           | VARCHAR |                                          |


## Running the Project
To run this application locally, you will need bash and a running PostgreSQL instance.

1. **Clone the Repository**
    2. 
    ```bash
    git clone https://github.com/simonmatome/FCC-salon-scheduler.git
    cd FCC-salon-scheduler
    ```
1. **Set Up the Database**
   - Ensure your PostgreSQL server is running.
   - Run the salon.sql file to create the salon database, tables, and insert the initial services.
     
    ```psql
    psql -U postgres -f salon.sql
    ```

    *(Note: You may need to adjust the -U postgres flag based on your local PostgreSQL setup.)*

1. **Make the Script Executable**
   ```bash
   chmod +x salon.sh
   ```

1. **Run the Application**
   ```bash
   ./salon.sh
   ```

   You will be greeted with the list of services and can proceed to book an appointment.
