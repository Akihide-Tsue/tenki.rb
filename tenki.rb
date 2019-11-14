require 'uri'
require 'net/http'
require 'json'
require 'date'

line = "----------------------"

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

  location = res["location"]["city"]
  today = Date.today.day
  tommorow = Date.today.day + 1
  forecasts = res["forecasts"]

  today_forecast = forecasts[0]
  today_telop = today_forecast["telop"]
  today_max = today_forecast["temperature"]["max"]["celsius"]

  tomorrow_forecast = forecasts[1]
  tomorrow_telop = tomorrow_forecast["telop"]
  tomorrow_min = tomorrow_forecast["temperature"]["min"]["celsius"]
  tomorrow_max = tomorrow_forecast["temperature"]["max"]["celsius"]

  puts "  #{location}の天気：
  今日(#{today}日)  ：#{today_telop}、最高気温:#{today_max}、最低気温:データなし
  明日(#{tommorow}日)  ：#{tomorrow_telop}、最高気温:#{tomorrow_max}、最低気温:#{tomorrow_min}"
  puts "----------------------"
end

def end_program
  exit
end

def exception
  puts "入力された値は無効な値です"
end

while true do           # メニューの表示
  puts "\n[1]東京の天気を見る\n[2]大阪の天気を見る\n[0]アプリを終了する"
  puts "\nLivedoor お天気Webサービス API ：\nhttp://weather.livedoor.com/forecast/rss/primary_area.xml"
  puts line

  input = gets.to_i
    if input == 1 then
      tenki_tokyo
    elsif input == 2 then
      tenki_osaka
    elsif input == 0 then
      end_program         # end_programメソッドの呼び出し
    else
      exception           # exceptionメソッドの呼び出し
  end
end