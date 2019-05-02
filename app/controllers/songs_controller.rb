class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"songs/index"
  end

  get '/songs/new' do
    erb :"songs/new"
  end

  post '/songs' do
    @song = Song.create(params[:song])
    if Artist.all.find |artist| do
      artist.name == params[:artist][:name]
    end
      @artist = Artist.create(params[:artist])
    end
    @genre = Genre.create(params[:genre][])
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

end
