require 'bundler'
Bundler.setup :default

require 'logger'
require 'life-api'

puts Life::API::VERSION

msisdn = '38xxxxxxxxx'
password = 'xxxxxx'

life = Life::API.new(msisdn: msisdn, password: password, lang: 'en')
life.log = Logger.new($stderr)
life.sign_in

summary_data = life.get_summary_data

tariff = summary_data['subscriber']['tariff']['name']
puts "Tariff: #{tariff}"

line_suspend_date = summary_data['subscriber']['attribute'].select{ |f| f['name'] == "LINE_SUSPEND_DATE" }.first['content']
line_suspend_date = Time.mktime(line_suspend_date).strftime("%d.%m.%Y")
puts "Suspend date: #{line_suspend_date}"

puts

balance = summary_data['subscriber']['balance']
main = balance.select{ |f| f['code'] == 'Line_Main' }.first['amount']
bonus =  balance.select{ |f| f['code'] == 'Line_Bonus' }.first['amount']
debt =  balance.select{ |f| f['code'] == 'Line_Debt' }.first['amount']
puts "Main: #{main} ₴"
puts "Bonus: #{bonus} ₴"
puts "Dept: #{debt} ₴"


puts "\nBalances:"
balances =  life.get_balances
balances['balance'].keep_if{ |i| i['amount'].to_i != 0 }.each do |i|
  puts " * #{i['name']}: #{i['amount']} #{i['measure']}"
end

life.sign_out
