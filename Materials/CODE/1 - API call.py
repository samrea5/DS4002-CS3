import yfinance as yf
import pandas as pd
from datetime import datetime, timedelta

# Function to fetch data for a specific date range
def fetch_data(symbol, start_date, end_date, interval="1mo"):
    # Fetch historical data using yfinance
    data = yf.download(symbol, start=start_date, end=end_date, interval=interval)
    return data

# Function to fetch monthly data for the given asset
def fetch_monthly_data(symbol, start_year, end_year):
    # Initialize an empty DataFrame to store monthly data
    monthly_data = pd.DataFrame()

    # Iterate through years
    for year in range(start_year, end_year + 1):
        # Define start and end dates for the current year
        start_date = datetime(year, 1, 1)
        end_date = datetime(year, 12, 31)

        # Fetch monthly data for the current year
        year_data = fetch_data(symbol, start_date, end_date)

        # Concatenate the year's data to the overall DataFrame
        monthly_data = pd.concat([monthly_data, year_data])

    return monthly_data

def main():
    # Define assets to fetch data for
    assets = {
        "S&P 500": "^GSPC",
        "Crude Oil": "CL=F",  # Symbol for NYMEX crude oil futures
        "Energy ETF 1": "XLE",  # Energy Select Sector SPDR Fund
        "Energy ETF 2": "VDE"   # Vanguard Energy ETF
    }

    # Initialize an empty DataFrame to store all data
    all_data = {}

    # Fetch data for each asset
    for asset_name, symbol in assets.items():
        print(f"Fetching data for {asset_name}...")
        asset_data = fetch_monthly_data(symbol, 1993, 2023)
        all_data[asset_name] = asset_data

    # Save the collected data to CSV files
    for asset_name, data in all_data.items():
        data.to_csv(f"{asset_name.replace(' ', '_').lower()}_monthly_data_1993_2023_Final.csv")

if __name__ == "__main__":
    main()
