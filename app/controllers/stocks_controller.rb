
class StocksController < ApplicationController

  def index
    @user = current_user
    @stocks = Stock.all
    @stocks_sum = 0;

    @stocks.each do |stock|
      if stock.price
        @stocks_sum = @stocks_sum + stock.price
      end  
    end 
  end 

  def new
    @stock = Stock.new

  end

  def edit
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user_id = current_user.id

    # Setup authorization
    @api_call = Intrinio.configure do |config|
        config.api_key['api_key'] = 'OjUyOGY1MjM0ZmE1OGYzM2I1ZDY2MjA0OWNiOGQ5Zjc5'
      end
      security_api = Intrinio::SecurityApi.new
      identifier = "#{@stock.ticker}" # String | A Security identifier (Ticker, FIGI, ISIN, CUSIP, Intrinio ID)
      opts = { 
        source: nil
      }
      begin
        result = security_api.get_security_realtime_price(identifier, opts)
        puts result
        @stock.price = @stock.shares * (result.last_price);
      rescue Intrinio::ApiError => e
        puts "Exception when calling SecurityApi->get_security_stock_prices: #{e}"
      end

    if @stock.save
      redirect_to stocks_path(@stock)
    else 
      render :new 
    end 

  end 


  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end 
  end

  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def stock_params
      params.require(:stock).permit(:user_id, :ticker, :shares, :price)
    end

    # Many failed API call attempts

    # Switching from yahoo finance to alpha vantage: OQM57GJJ6L5WU09S
    def find_stock(url)
      response = Excon.get(
        url,
        headers: {
          "function": "TIME_SERIES_INTRADAY",
          "symbol": "#{stock}",
          "accesskey": "924-1562307531-a10YmE4+XL7MiJHROzyMOrVKldLK2zNOTJ+IClDbqiQ=",
          "outputsize": "full",
          "apikey": ENV["OQM57GJJ6L5WU09S"]
        }
      )
      return nil if response.status != 200
      stock = JSON.parse(response.body)
      # self.prices = stock["Time Series (Daily)"]
    end

    def find_ticker(name)
      find_stock(
        "" 
      )
    end 

    def request_api_RAPID_API_YAHOO_FINANCE(url)
      response = Excon.get(
        url,
        headers: {
           'X-RapidAPI-Host' => URI.parse(apidojo-yahoo-finance-v1.p.rapidapi.com).host,
           'X-RapidAPI-Key' => ENV.fetch('a61e7cbcbfmsh4f224d73a4003a1p181792jsncaa3ff879ac4')
        }
      )
      return nil if response.status != 200
      JSON.parse(response.body)
    end

    def find_stock_RAPID_API(name)
      # Problem here
      request_api(
        "https://rapidapi.com/apidojo/api/yahoo-finance1/#{URI.encode(name)}"
      )
    end 

    def ticker_price_RAPID_API(regularMarketOpen, currentPrice)
      query = URI.encode("#{regularMarketOpen},#{currentPrice}")

      request_api(
        "https://rapidapi.com/apidojo/api/yahoo-finance1/#{URI.encode(name)}"
      )
    end 

    # Search for opening/current price
    def search_openingPrice
      @stock = find_stock(params[:stock])
      # added for API integration attempt
      unless @stock 
        flash[:alert] = "Ticker not found"
        return render action :index
      end 

      @ticker = stock.first
      @ticker_price = find_price(@ticker['regularMarketOpen'], @ticker['currentPrice'])
    end 

end 


  
