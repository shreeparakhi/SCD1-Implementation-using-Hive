# SCD1-Implementation-using-HIVE
A company ABC receives the data about the purchase made on their website by customers on a daily basis. To streamline the data collection and analysis, the company wishes to load all the data on a relational database system so that it can be accessible easily. Also, they need to maintain the data which is up-to –date i.e if there is any change made in the purchase order, it must overwrite the previous data reflect in the database.

## Approch:
We follow a step-by-step process in achieving the solution for the above-mentioned problem:

1. Load the data from client's machine and create a table on MySQL.
2. Load the data into Hive Table.
3. Implement SCD-1 to keep the up-to-date data.
4. Load the data back into MySQL.
5. Create a backup table for reconciliation.

## Block Diagram:
![WhatsApp Image 2022-03-04 at 5 07 09 PM](https://user-images.githubusercontent.com/100192175/157570169-4b3b7f2a-667d-4263-a45b-1016795da8a5.jpeg)

## Directory Structure:
<img width="359" alt="image" src="https://user-images.githubusercontent.com/100192175/157570244-158c0eee-e596-4819-8750-2feafe081dad.png">

