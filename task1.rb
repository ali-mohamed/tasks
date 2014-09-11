class Numeric
  @@currencies = {  egp: 1,  dollar: 7.15,  euro: 9.26,  yen: 0.068, 
				   egps: 1, dollars: 7.15, euros: 9.26, yens: 0.068 }
 
  def convert_currency(transfer)
    self * @@currencies[transfer[:from]] / @@currencies[transfer[:to]]
  end
  
  def self.add_currency(currency_value)
	currency_value.each do |currency, rate|
		@@currencies[currency] = rate
		@@currencies["#{currency}s".to_sym] = rate
	end		
   end
  
end

puts 3.convert_currency from: :euros ,to: :dollars
Numeric.add_currency(saudi_riyal: 1.9)
puts 3.convert_currency from: :egps ,to: :saudi_riyals