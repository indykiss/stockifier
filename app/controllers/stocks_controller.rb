
class StocksController < ApplicationController
  helper_method :current_user 

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

  def create
    @stock = Stock.new(stock_params)
    @stocks = Stock.all
    @stock.user_id = current_user.id

    # Setup authorization for API call
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

    # Can't buy anymore stock if spent more than $5000
      # Idea is to disable the submit button if slightly in debt 
    # @stocks_sum = 0;
    # @can_i_buy = false;

    # @stocks.each do |stock|
    #   if stock.price
    #     @stocks_sum = @stocks_sum + stock.price
    #   end  
    # end 

    # if @stocks_sum < 0 
    #   @can_i_buy = false
    # end 
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

end 


  
