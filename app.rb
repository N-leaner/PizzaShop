#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base

end	

get '/' do
	@products = Product.all
	@order_inp = ''
	@order_bname = 'Check out order (..)'
	erb :index
end

get '/about' do
	erb :about
end	

get '/cart' do
	erb :cart
end	

def get_hh_order str
	arr = str.split(',')
	hh = {}
	arr.each do |i|
		arh = i.split('=')
		hh[arh[0].split('_')[1]] = arh[1].to_i	
	end	
	return hh
end

post '/cart' do	
	@order_inp = params[:orders].strip
	it_summ = 0
	@hh_order = get_hh_order @order_inp
	@hh_order.each {|k,v| it_summ = it_summ + v}
	@order_bname = 'Check out order ( '+it_summ.to_s+' )'
	erb :cart
end	

post '/order'do
	erb :order
end