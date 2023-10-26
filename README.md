# BuyMe

Project Overview:
Full-stack web app similar to eBay where users can bid/sell items, ask questions to customer representatives, set alerts on their favorite items, view the history of bidding on an item, and much more!


Tech Stack Used:
Front-End: HTML and JavaScript for the user interface.
Back-End: Java for the server-side logic, MySQL for the relational database management, and JDBC for connecting the user interface with the database.
Web Server: Tomcat for hosting the web application.



Key Functionalities:

User Accounts:
Users can create and delete accounts.
Users can log in and log out.

Auctions:
Sellers can create auctions and list items for sale.
Sellers set item characteristics, closing date and time, minimum price (reserve), and bid increment.
Buyers can place bids and set new bids.
Automatic bidding is supported, where buyers set secret upper limits.
Alerts are sent to other buyers when a higher manual bid is placed.
Buyers are alerted if someone bids higher than their automatic bid limit.
The system determines the auction winner based on the highest bid.
For auctions with a reserve price, if the reserve is not met, no winner is declared.
If there is no reserve, the highest bidder wins.
The winner is alerted.

Browsing and Advanced Search:
Users can browse items and view the current bidding status.
Sorting options available based on various criteria (e.g., type, bidding price).
Search functionality allows users to find items using multiple criteria.
Users can view the bid history for specific auctions.
Lists of auctions a specific buyer or seller has participated in can be accessed.
Users can find "similar" items listed in the preceding month.
Alert system for items users are interested in.

Admin and Customer Rep Functions:
Admin can create accounts for customer representatives.
Admin can generate sales reports, including total earnings and earnings by item, item type, and end-user.
Customer representatives handle user questions and can modify user information.
Customer reps can reset passwords and remove bids.
Administrative staff members oversee system administration tasks, including creating customer rep accounts and generating sales reports.
This project aims to replicate the core functionalities of an online auction platform while adding some unique features, such as item alerts and comprehensive sales reporting. It involves a full tech stack with a web interface and a relational database to support these operations.


[Walkthrough of application](https://youtu.be/_CWA_v4f1sw)


[![Full walkthrough of app](https://user-images.githubusercontent.com/19865455/177832068-2607f1c1-7935-481d-9cc4-fdab27bb9b52.png)](https://youtu.be/_CWA_v4f1sw "Walkthrough of application - Click to Watch!")
