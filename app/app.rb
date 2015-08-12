require 'sinatra/base'
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
    Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/form'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
