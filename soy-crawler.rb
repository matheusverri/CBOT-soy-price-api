require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'rufus-scheduler'

set :protection, except: :json_csrf

scheduler = Rufus::Scheduler.new

price = nil
variation = nil
paranagua_price = nil
santos_price = nil

scheduler.every '5m' do
  #CBOT
  doc = Nokogiri::HTML(URI.open('https://br.investing.com/commodities/us-soybeans'))
  price_and_variation = doc.css('div.gap-x-4').css('.font-bold')
  price = price_and_variation.first.content
  variation = price_and_variation[1].content

  # PARANAGUÁ
  paranagua_doc = Nokogiri::HTML(URI.open('https://www.noticiasagricolas.com.br/cotacoes/soja'))
  paranagua_price = paranagua_doc.css('div.cotacao').css('table.cot-fisicas').css('td')[1].content

  # SANTOS
  santos_doc = Nokogiri::HTML(URI.open('https://www.noticiasagricolas.com.br/cotacoes/soja/soja-mercado-fisico-sindicatos-e-cooperativas'))
  santos_price = santos_doc.css('tbody').first.css('tr').last.css('td')[1].content

  puts 'Preço Atualizado - ' + Time.now.to_s
end

scheduler.join

get '/' do
  content_type :json
  {
    Location: 'Chicago CBOT',
    Price: price,
    Unit: 'US$/Bu',
    Variation: variation
  }.to_json
end

get '/cbot-price' do
  content_type :json
  {
    Location: 'Chicago CBOT',
    Price: price,
    Unit: 'US$/Bu',
    Variation: variation
  }.to_json
end

get '/paranagua-price' do
  content_type :json
  {
    Location: 'Paranaguá',
    Paranagua_price: paranagua_price,
    unit: 'R$/SC60kg'
  }.to_json
end

get '/santos-price' do
  content_type :json
  {
    Location: 'Santos/SP',
    santos_price: santos_price,
    unit: 'R$/SC60kg'
  }.to_json
end
