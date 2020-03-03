json.extract! portfolio, :id, :user_id, :ticker, :price, :shares, :created_at, :updated_at
json.url portfolio_url(portfolio, format: :json)
