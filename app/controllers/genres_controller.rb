class GenresController < ApplicationController

  before_action :require_signin
  before_action :require_admin, except: :show

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      redirect_to genres_url, notice: "Genre Successfully Created!"
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_url, notice: "Genre Successfully Updated!"
    else
      render :edit
    end
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end

end
