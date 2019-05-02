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

    Artist.all.each do |artist|
      if params[:artist][:name] == artist.name
        @song.artist = artist
      end
    end

    binding.pry    

    if !@song.artist.empty?
      @artist = Artist.create(params[:artist])
      @song.artist = @artist
      @song.save
    end

    @genre = Genre.create(params[:genre][])

    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

end
