#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base

end	

class Order < ActiveRecord::Base
	validates :name, presence: true, length: {minimum: 3}
	validates :phone, presence: true
	validates :adress, presence: true	
end	

get '/' do
	@products = Product.all
	@ore = 0
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
	@ore = 0
	it_summ = 0
	@hh_order = get_hh_order @order_inp
	@hh_order.each {|k,v| it_summ = it_summ + v}
	@order_bname = 'Check out order ( '+it_summ.to_s+' )'
	erb :cart
end	

post '/order'do	
	@ore = 1
	@order_inp = params[:order_conf].strip
	@hh_order = get_hh_order @order_inp

	erb :order
end