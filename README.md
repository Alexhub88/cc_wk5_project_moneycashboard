# MoneyCashBoard Budget Tracker

MoneyCashBoard is a web application made with Ruby and Sinatra. Following a Model View Controller design, and a RESTful route 
architecture for saving and accessing data on a PostgreSQL database, it allows the user to track spending by spending type
(called Tagtype in the application) and Merchant, i.e. the store where the item was purchased. It also allows the user to find
a breakdown of the total spending by Tagtype, as well as by month.

## To run the application
* Clone the repository to a local network folder using the 'git clone' command:       git@github.com:Alexhub88/cc_wk5_project_moneycashboard.git
* Enter the folder 
* Enter: 'ruby app.rb' and press enter
* Open Google Chrome and go to `http://localhost:4567/`, then press enter
* This will take the user to the Home page of the website, which then shows the user the options for finding the total spending
  and the breakdowns by Tagtype and Merchant.
