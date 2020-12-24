require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes/new' do
    erb :new
  end
  
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    find_by_id
    erb :show
  end

  get '/recipes/:id/edit' do
    find_by_id
    erb :edit
  end

  patch '/recipes/:id' do
    find_by_id
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    find_by_id
    @recipe.delete
    redirect to '/recipes'
  end

  private

  def find_by_id
    @recipe = Recipe.find_by_id(params[:id])
  end
end
