require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

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
        @song.save
      end
    end

    if !@song.artist
      @artist = Artist.create(params[:artist])
      @song.artist = @artist
      @song.save
    end

    @genre = Genre.create(params[:genre])
    @song.genres << @genre
    @song.save

    flash[:message] = "Successfully created song."

    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.all.find_by_slug(params[:slug])

    erb :"songs/edit"
  end

  patch '/songs/:id' do
    @song = Song.find(params[:id])
    @song.update(params[:song])
    @song.artist.update(params[:artist])
    @song.save

    if params[:genre] != nil
      @song.genres << Genre.create(params[:genre])
      @song.save
    end

    flash[:message] = "Successfully updated song."

    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"songs/show"
  end

end
