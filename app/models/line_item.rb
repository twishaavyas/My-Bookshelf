class LineItem < ApplicationRecord
	belongs_to :product
	# belongs_to :order
	belongs_to :cart
	def total_price		
		product.price * quantity
	end

	def remove_item(line_item)
		line_item.quantity -= 1
		
		line_item
	end
end
