# Stockifier

In Stockifier, you'll be given $5000 to play with in the stock market's DOW 30 companies. You can buy stocks at their current price, see your portfolio, and audit all the transactions you've made. 

Stockifier is up on heroku and can be found here: https://stockifier.herokuapp.com/

I created Stockifier for a week long code assessment. With the time constraints, there are currently a few build issues. As I continue building out Stockifier after the challenge's final assessment, I'll fix these problems.

## Current issues
- **All users share one portfolio, one transactions page, and one lump sum of $5000. There's a substantial issue with data accessing in current_user and @stocks_sum in the StocksController. Ideally I should add a budget field (min: 0) to the user's schema instead of the current hard-coded process.** 
- Users are able to purchase negative shares. Users are able to spend more than $5000 and go into debt. A few well-placed if/else statements can probably remedy these two problems. 
- Portfolio does not list current value of portfolio with real time prices. This is an issue with data structures; I implemented portfolio using a hash of all stocks, with :share => quantity. In actuality, I should implement a better solution using an API call to pull stock values.
- The the font color of tickers and current prices in the portfolio do NOT change dynamically to indicate performance. That would be a nice feature to show users how each stock is doing. 
- Users only have access to DOW 30 companies. This is due to a limited dataset in the Intrinio API sandbox. I can maybe fix by using a different API or expanding subscription. 
- In Portfolio, it would be great to implement a portfolio value over time graph to see how well the users' investments paid off. 
- It would also be nice to let users sell stocks and use this new income to continue investing. 
- This is not the prettiest app. It would be great to add React to make this more responsive and a single page application. 


# Built with:
#### Ruby on Rails, Bootstrap for basic formatting
#### Bcrypt is used for secure password hashing


# How to use: 
Navigate to: https://stockifier.herokuapp.com/

Sign up using name, email, and a secure password. 

Apologies in advance for any sign up/ login issues. This process was being a little fincky the last I checked on it. 

# API Reference 

API used for pulling current real time stock prices for DOW30 stocks. <br/>
https://intrinio.com/ 
<br/>
