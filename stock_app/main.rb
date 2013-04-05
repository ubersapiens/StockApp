# main.rb
require 'sinatra'
require 'yahoofinance'

# GET stock page
get '/stock' do

#Top stocks list
  values = {}
  
  topstocks = ['AAPL','EBAY','GOOG','YHOO','BP','BBRY','FB','GRPN','ARMH']
  
  topstocks.each do |symbols|
  	trade_values = erb YahooFinance::get_quotes(YahooFinance::StandardQuote, symbols)[symbols].lastTrade.to_s
  	values[symbols.to_sym] = trade_values
  end

  puts values.to_s

  erb :find_stock, locals: { values: values } 

end

# POST to stock page
post '/stock' do
  stock_ticker = request.POST['ticker'].upcase
  value = YahooFinance::get_quotes(YahooFinance::StandardQuote, stock_ticker)[stock_ticker].lastTrade.to_s

  erb :stock, locals: { ticker: stock_ticker, value: value }
end

