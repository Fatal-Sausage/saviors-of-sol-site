README  
======  

To get up and running:  
----------------------

1.  Clone this repository  
`git clone <this repo>`    
  
2.  Navigate to the project root and run  
`bundle install`  
to install required gems  
  
3.  Create the database:  
`rake db:create`

4.  Migrate the database (update it with the latest schema)  
`rake db:Migrate`  
  
5.  Start the rails server with  
`rails s`  

6.  And go to 127.0.0.1:3000 in a browser to view the project  

Some Notes  
----------  
* Ruby version 2.2.0, Rails version 4.2
  
* The API key is set to read from an environemt variable named `BUNGIE_API_KEY`  
  
* Get an API key [here](https://www.bungie.net/en/User/API)  
  
Contributing:  
-------------  

* First off: feel free to contribute!  
* To avoid chaos, if you want to add you changes to the project, please, please, please create a pull request.  
  We won't be able to manage it any other way. If you hit a bug and you don't feel like fixing it yourself, please open an issue in this repo.  

