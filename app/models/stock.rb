

class Stock < ApplicationRecord
    belongs_to :user

    # Must need a scope here to get the stocks all in a single page 
        # aggregating same-stocks with price & quantity 
    # scope :top_five, -> {joins(:favorites).group(:id).order("Count(favorites.id) DESC").limit(5)}


end
