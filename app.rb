require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:leprosorium.db"

class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :content, presence: true, length: { minimum: 1 }
end

class Comment < ActiveRecord::Base
  belongs_to :post
end

before do
  @posts = Post.order 'created_at DESC'
end

get '/' do
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
   @c = Post.new (params[:post])

  if @c.save
    erb "<h1>Ваш пост опубликован</h1>"
  else
    @error = @c.errors.full_messages.first
    erb :new
  end
end

get '/details/:comm_id' do

  @post = Post.find (params[:comm_id])
  @comments = Comment.where("post_id=?", params[:comm_id]).order('created_at DESC')
  
  erb :details
end

post '/details/:comm_id' do
  #@post_id = params[:comm_id]
  #@comment = @post.comments.create (params[:comm])
  @comment = Comment.new (params[:comm])
  @comment.post_id = params[:comm_id]
  
  if @comment.save
    redirect to ('/details/'+ params[:comm_id])
  else
    @error = @comment.errors.full_messages.first
    redirect to ('/details/'+ params[:comm_id])
  end
end