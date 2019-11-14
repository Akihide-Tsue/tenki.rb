require 'uri'
require 'net/http'
require 'json'
require 'date'

def read_tenki
  puts "[1]東京の天気"
  puts "[2]大阪の天気"
  input = gets.to_i
    if input == 1 then
      tenki_tokyo
    elsif input == 2 then
      tenki_osaka
    else
      exception
      read_tenki
    end
end

def tenki_tokyo
  tokyo = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
  info(tokyo)
end

def tenki_osaka
  osaka = "http://weather.livedoor.com/forecast/webservice/json/v1?city=270000"
  info(osaka)
end

def info(place)
  uri = URI.parse(place)
  res = Net::HTTP.get(uri)
  res = JSON.parse(res)
  forecasts = res["forecasts"]
  today_forecast = forecasts[0]
  today_telop = today_forecast["telop"]
  tomorrow_forecast = forecasts[1]
  tomorrow_telop = tomorrow_forecast["telop"]
  location = res["location"]["city"]
  today = Date.today.day
  tommorow = Date.today.day + 1
  puts "  #{location}の天気：
  今日(#{today}日)：#{today_telop}、
  明日(#{tommorow}日)：#{tomorrow_telop}"

end

def end_program
  exit
end

def exception
  puts "入力された値は無効な値です"
end

while true do           # メニューの表示
  puts "[1]天気を見る"
  puts "[0]アプリを終了する"
  input = gets.to_i
  if input == 1 then    # read_tenkiメソッドの呼び出し
    read_tenki
  elsif input == 0 then
    end_program         # end_programメソッドの呼び出し
  else
    exception           # exceptionメソッドの呼び出し
  end
end