require('sinatra')
require('pry')
require('sinatra/contrib/all')
require_relative('models/transaction')
require_relative('models/merchant')
require_relative('models/tagtype')

get '/transactions' do
  @transactions = Transaction.all
  erb(:index)
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tagtypes = TagType.all
  erb(:new)
end

post '/transactions' do
  Transaction.new(params).save
  redirect to '/transactions'
end

get '/transactions/:id' do
  @transaction = Transaction.find(params['id'].to_i)
  @merchant = Merchant.find(@transaction.merchant_id)
  @tagtype = TagType.find(@transaction.tagtype_id)
  erb(:show)
end

get '/transactions/:id/edit' do
  @merchants = Merchant.all
  @tagtypes = TagType.all
  @transaction = Transaction.find(params['id'].to_i)
  erb(:edit)
end

post '/transactions/:id' do
  @transaction = Transaction.new(params)
  @transaction.update
  redirect to "/transactions/#{params['id']}"
end

post '/transactions/:id/delete' do
  @transaction = Transaction.find(params['id'].to_i)
  @transaction.delete
  redirect to '/transactions'
end
