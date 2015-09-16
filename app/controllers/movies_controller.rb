class MoviesController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    # case params[:scope]
    # when "hits"
    #   @movies = Movie.hits
    # when "flops"
    #   @movies = Movie.flops
    # when "upcoming"
    #   @movies = Movie.upcoming
    # when "recent"
    #   @movies = Movie.recent
    # else
    #   @movies = Movie.released
    # end
    @movies = Movie.send(movies_scope)
    @genres = Genre.all
  end

  def show
    @movie = Movie.find(params[:id])
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @current_favorite = @movie.favorites.find_by(user_id: current_user.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created!"
    else
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_url, alert: "Movie successfully deleted!"
  end

  private

    def movie_params
      params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image, genre_ids: [])
    end

    def movies_scope
      if params[:scope].in? %w(hits flops upcoming recent)
        params[:scope]
      else
        :released
      end
    end
end
