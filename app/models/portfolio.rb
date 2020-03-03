


# Might not need this connection. 
# Might just be good with doing a stocks scope. 
# We shall seeeee

class Portfolio < ApplicationRecord
    belongs_to :user 
    has_many :stocks
end
