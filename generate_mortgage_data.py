
#Import necessary libraries
#pandas for data handling, Faker for generating fake data, random for generating random values, and timedelta for working with time intervals.
import pandas as pd
from faker import Faker
import random
from datetime import timedelta

# Set seeds for random number generator and initialize the Faker instance for generating fake data
random.seed(42)
fake = Faker()

# Define the list of 50 possible county names using the fake.city() method from the Faker library
possible_counties = [fake.city() for _ in range(50)]

# Sets the number of fake mortgage loans to generate to 1000
num_loans = 1000

# Initialize an empty list to store the generated data.
data = []

#Starts a loop that will iterate num_loans times
#Generates random values for loan_balance between 80000 and 300000, then calculates loan_limit by subtracting a random value between 1000 and 20000. Calculates arrears as the difference between loan_balance and loan_limit.
#Randomly selects a loan type from the list ['PDH', 'PDH Topup', 'BTL', 'BTL Topup'].
#Generates a random start date between 5 years ago and today using fake.date_between(). Calculates a random end date between 10 and 30 years after the start date using the timedelta class.
#Generates fake customer first name, last name, and gender using Faker's methods.
for _ in range(num_loans):
    loan_balance = random.randint(80000, 300000)
    loan_limit = max(0, loan_balance - random.randint(1000, 20000))
    arrears = loan_balance - loan_limit 
    loan_type = random.choice(['PDH', 'PDH Topup', 'BTL', 'BTL Topup'])
    start_date = fake.date_between(start_date='-5y', end_date='today')
    end_date = start_date + timedelta(days=random.randint(3650, 10950))  # 10 to 30 years
    customer_first_name = fake.first_name()
    customer_last_name = fake.last_name()
    gender = fake.random_element(['Male', 'Female'])
    address = fake.street_address()
    address_line_2 = fake.secondary_address() if random.random() < 0.5 else None
    county = random.choice(possible_counties)
    
    # Limit the security address county to a different name from the main county
    security_address_county = random.choice([c for c in possible_counties if c != county])
    
    data.append({
        'Loan_balance': loan_balance,
        'Loan_limit': loan_limit,
        'Arrears': arrears,
        'Account Number': 1001 + _,
        'Start Date': start_date,
        'End Date': end_date,
        'Loan Type': loan_type,
        'Customer First Name': customer_first_name,
        'Customer Last Name': customer_last_name,
        'Gender': gender,
        'Address Line 1': address,
        'Address Line 2': address_line_2,
        'County': county,
        'Security Address Line 1': address,
        'Security Address Line 2': address_line_2,
        'Security Address County': security_address_county
    })

# Create a DataFrame
df = pd.DataFrame(data)

# Export DataFrame to a CSV file
df.to_csv('fake_mortgage_loans.csv', index=False)
