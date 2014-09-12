class Numeric
	require 'rubygems'
	require 'open-uri'
	require 'json'
  @@currencies = {  egp: 7.15,  dollar: 1,  euro: 0.77,  yen: 0.0095, 
				   egps: 7.15, dollars: 1, euros: 0.77, yens: 0.0095 }
 
  @@currency_definations = { egp: "EGP",  dollar: "USD",  euro: "EUR",  yen: "JPY", 
							egps: "EGP", dollars: "USD", euros: "EUR", yens: "JPY" }
 
 
  def convert_currency(transfer)
	@@currencies[transfer[:to]]   = self.get_currency_rate_from_api(@@currency_definations[transfer[:to]]) if @@currency_definations.has_key?(transfer[:to])
	@@currencies[transfer[:from]] = self.get_currency_rate_from_api(@@currency_definations[transfer[:from]]) if @@currency_definations.has_key?(transfer[:from])
    self * @@currencies[transfer[:to]] / @@currencies[transfer[:from]]
  end
  
  def self.add_currency(currency_value)
	currency_value.each do |currency, rate|
		@@currencies[currency] = @@currencies[:egp] / rate
		@@currencies["#{currency}s".to_sym] = @@currencies[:egp] / rate
	end		
   end
  
	protected
	def get_currency_rate_from_api(transfer_currency)
	  my_web_site = "http://api.exchangeratelab.com/api/single/#{transfer_currency}?apikey=8C00BCA8047599D3FBEEDF59BB78DC98"
	  data = URI.parse(my_web_site)
	  webpage = data.read unless transfer_currency == "USD"
	  return 1 if transfer_currency == "USD"
	  #/{"rate":([^,]+),"to":#{transfer_currency}}/.match(webpage)
	  /{"rate":{"rate":([^,]+),"to":"USD"}/.match(webpage)
	  $1.to_f
	end
end

puts 3.convert_currency from: :egps ,to: :dollars
Numeric.add_currency(saudi_riyal: 1.9)
puts 3.convert_currency from: :egps ,to: :saudi_riyals