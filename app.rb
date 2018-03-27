require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :content, presence: true, length: { minimum: 1 }
end

class Comment < ActiveRecord::Base
end

before do
  @posts = Post.all
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

  if @c.save
    erb "<h1>Ваш пост опубликован</h1>"
  else
    @error = @c.errors.full_messages.first
    erb :new
  end
end

get '/details/:id' do
  erb :details
end