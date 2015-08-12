require 'sinatra/base'
require_relative 'data_mapper_setup'
class BookmarkManager < Sinatra::Base
  # set :views, proc { File.join(root,'..','views') }

  get '/' do
    'Hello BookmarkManager!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect to('/links')
  end

  get '/links/form' do
    erb :'links/form'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
