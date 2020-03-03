
class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]


  def index
    @portfolios = Portfolio.all

    @stocks = Stock.all
    @portfolio = {}
    @portfolio_value = {}

    @stocks.each { |i|
      if @portfolio.include?(i.ticker) 
        @portfolio[i.ticker] += i.shares
      else 
        @portfolio[i.ticker] = i.shares
      end 
    } 
    # Ideally would create an API call here grabbing all the current 
    # values of the porfolio
      # Ex: IBM's current value (from API) * number of shares = IBM's value 
      # Do the above for all stocks in portfolio
      # Present the total value of portfolio
  end


  private
    def portfolio_params
      params.require(:portfolio).permit(:user_id, :ticker, :price, :shares)
    end
end
