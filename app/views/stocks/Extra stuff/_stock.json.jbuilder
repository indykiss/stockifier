json.extract! stock, :id, :user_id, :ticker, :shares, :created_at, :updated_at
json.url stock_url(stock, format: :json)
