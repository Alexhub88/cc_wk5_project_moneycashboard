require('sinatra')
require('pry')
require('sinatra/contrib/all')
require_relative('../models/merchant')

get '/merchants' do
  @merchants = Merchant.all
  erb(:'merchants/index')
end

get '/merchants/new' do
  erb(:'merchants/new')
end

post '/merchants' do
  Merchant.new(params).save
  redirect to '/merchants'
end

get '/merchants/:id' do
  @merchant = Merchant.find(params['id'].to_i)
  erb(:'merchants/show')
end

get '/merchants/:id/edit' do
  @merchant = Merchant.find(params['id'].to_i)
  erb(:'merchants/edit')
end

post '/merchants/:id' do
  @merchant = Merchant.new(params)
  @merchant.update
  redirect to "/merchants/#{params['id']}"
end

post '/merchants/:id/delete' do
  @merchant = Merchant.find(params['id'].to_i)
  @merchant.delete
  redirect to '/merchants'
end
