require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  
  #home route
  get '/' do
    end
  
  #new article
  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do
    @article = Article.create(params)
    
    redirect "/articles/#{@article.id}"
  end
  
  #index route
  get '/articles' do
    @articles = Article.all
    
    erb :index
  end
  
  #articles/show
  get '/articles/:id' do
    @article = Article.find(params["id"])
    
    erb :show
  end
  
  #update
  get '/articles/:id/edit' do
    @article = Article.find(params["id"])
    
    erb :edit
  end

  patch '/articles/:id' do
    new_params = {}
    old_post = Article.find(params["id"])
    new_params[:title] = params["title"]
    new_params[:content] = params["content"]
    old_post.update(new_params)

    redirect "/articles/#{params["id"]}"
  end
  
  delete '/articles/:id/delete' do
    @article = Article.find(params["id"])
    @article.destroy
    erb :delete
  end
  
end
