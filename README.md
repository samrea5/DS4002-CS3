# DS4002-CS3
This github contains a Case study that explores predicting the price of gasoline using economic data. The goal of this case study is to create a basic machine learning model in R using the caret package. The below readme file contains information on how to execute the following case study as well as background information.

# Gas-Price-Modelling
This is a case study at predicting US Average Gas Prices based on a variety of monthly variables, including Unemployment, CPI, and economic indicators for Crude Oil, the S&P 500, and the XLE and VDE Energy ETFs. Using basic machine learning models, these variables are used to predict Gas Prices for the following month.

# Section 1
## Software and Platform Section
This project requires running scripts in both Python and R. Python scripts were run in Visual Studio Code, while R scripts were run in R Studio. In Python, we used the yfinance package in order to pull data from the Yahoo Finance API. We used the datetime package in order to do our date encodings and the Pandas package in order to do some preliminary data cleaning. Within R, we used lubridate for date handling and the xlsx and readxl packages for preliminary data cleaning. The dplyr and ggplot packages were essential to add pipeline functionality and graphing ability in the scripts. Finally, the caret package was used for the actual modelling, having a variety of popular models available. The analysis was all carried out on the Mac OS platform.

# Section 2
## Documentation of the Project
Our repository contains three major folders. The first folder is the DATA folder. This folder contains the final_data.csv file which is ultimately fed into the modelling script. YOu can use all of the individual data files and combine them into a singular data frame. The second major folder is the CODE folder. This folder contains the scripts used to conduct analysis. FInally the Deliverable folder contains the an example of a deliverable for this case study.

# Section 3
## Instructions for Use
At the Bare minimum one need to have the final_data.csv downlaoded and the modeling script form the CODE folder. These two files should be enough to reproduce the results of this case study.

## References

[1] Factors Affecting Gasoline Prices - U.S. Energy Information Administration (EIA). https://www.eia.gov/energyexplained/gasoline/factors-affecting-gasoline-prices.php. Accessed 24 Mar. 2024.

[2] Federal Reserve Economic Data | FRED | St. Louis Fed. https://fred.stlouisfed.org/. Accessed 24 Mar. 2024.

[3] U.S. Regular All Formulations Retail Gasoline Prices (Dollars per Gallon). https://www.eia.gov/dnav/pet/hist/LeafHandler.ashx?n=pet&s=emm_epmr_pte_nus_dpg&f=m. Accessed 24 Mar. 2024.

[4] Yahoo Finance - Stock Market Live, Quotes, Business & Finance News. https://finance.yahoo.com/. Accessed 24 Mar. 2024.
