

class Stock < ApplicationRecord
    belongs_to :user

    # Must need a scope here to get the stocks all in a single page 
        # aggregating same-stocks with price & quantity 
    scope :portfolio, -> (ticker){where("name LIKE ?", ticker)}


end
