require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

get '/' do
  erb :index
end

get '/new' do
  @c = Post.new
  erb :new
end

post '/new' do
   @c = Post.new params[:post]
   @c.save
end