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
  
  #create
  get '/articles/new' do
    erb :new
  end
  
  post '/articles' do
    @article = Article.create(params)
    
    redirect "/articles/#{@article.id}"
  end
  
  #read
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
    @article = Article.find_by(id: params["id"])
    @article.update(title: params["title"], content: params["content"])
    
    redirect "/articles/#{@article.id}"
  end
  
  #delete
  delete '/articles/:id/delete' do
    @article = Article.find(params["id"])
    @article.destroy
    
    redirect "/articles"
  end
  
end
