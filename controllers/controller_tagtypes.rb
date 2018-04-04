require('sinatra')
require('pry')
require('sinatra/contrib/all')
require_relative('../models/tagtype')

get '/tagtypes' do
  @tagtypes = TagType.all
  erb(:'tagtypes/index')
end

get '/tagtypes/new' do
  erb(:'tagtypes/new')
end

post '/tagtypes' do
  TagType.new(params).save
  redirect to '/tagtypes'
end

get '/tagtypes/:id' do
  @tagtype = TagType.find(params['id'].to_i)
  erb(:'tagtypes/show')
end

get '/tagtypes/:id/edit' do
  @tagtype = TagType.find(params['id'].to_i)
  erb(:'tagtypes/edit')
end

post '/tagtypes/:id' do
  @tagtype = TagType.new(params)
  @tagtype.update
  redirect to "/tagtypes/#{params['id']}"
end

post '/tagtypes/:id/delete' do
  @tagtype = TagType.find(params['id'].to_i)
  @tagtype.delete
  redirect to '/tagtypes'
end
