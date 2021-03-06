  class AlbumsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource


  def index
    @albums = Album.all
  end

  def show
    @photo = Photo.new
    @photos = @album.photos.all
  end

  def new
    @album.user = current_user
  end

  def create
    @album.user_id = current_user.id
    if @album.save
      photo = Photo.new params[:photo]
      if photo.save
        @album.photos << photo
      else
        puts
        puts 'ERROR'
        puts photo.inspect
        puts
      end
      redirect_to current_user
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @album = Album.find params[:id]
    if @album.update_attributes params[:album]
      redirect_to @album
    else
      render action: "edit"
    end
  end

  def destroy
    album = Album.find params[:id]
    user = User.find(album.user_id)
    album.delete
    redirect_to user
  end

end
