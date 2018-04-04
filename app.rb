require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/controller_merchants')
require_relative('controllers/controller_tagtypes')
require_relative('controllers/controller_transactions')

get '/' do
  erb( :index )
end
