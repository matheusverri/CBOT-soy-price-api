require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'rufus-scheduler'

set :protection, except: :json_csrf

scheduler = Rufus::Scheduler.new

scheduler.every '3s' do
  puts 'Hello... Rufus'
end

doc = Nokogiri::HTML(URI.open('https://br.investing.com/commodities/us-soybeans'))
price_and_variation = doc.css('div.gap-x-4').css('.font-bold')
price = price_and_variation.first.content
variation = price_and_variation[1].content

# PARANAGUÁ
paranagua_doc = Nokogiri::HTML(URI.open('https://www.noticiasagricolas.com.br/cotacoes/soja'))
paranagua_price = paranagua_doc.css('div.cotacao').css('table.cot-fisicas').css('td')[1].content

get '/' do
  content_type :json
  { Price: price,
    Variation: variation
  }.to_json
end

get '/cbot-price' do
  content_type :json
  { Price: price }.to_json
end

get '/cbot-variation' do
  content_type :json
  { Variation: variation }.to_json
end

get '/paranagua-price' do
  content_type :json
  { paranagua_price: paranagua_price }.to_json
end


