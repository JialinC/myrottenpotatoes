class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  # def create
  #   params.require(:movie)
  #   permitted = params[:movie].permit(:title,:rating,:release_date)
  #   @movie = Movie.create!(permitted)
  #   flash[:notice] = "#{@movie.title} was successfully created."
  #   redirect_to movies_path
  # end

  # replaces the 'create' method in controller:
  def create
    params.require(:movie)
    permitted = params[:movie].permit(:title,:rating,:release_date)
    @movie = Movie.new(permitted)
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new' # note, 'new' template can access @movie's field values!
    end
  end

  def edit
    @movie = Movie.find params[:id]
  end

  # def update
  #   @movie = Movie.find(params[:id])
  #   permitted = params[:movie].permit(:title,:rating,:release_date)
  #   @movie.update!(permitted)
  #
  #   flash[:notice] = "#{@movie.title} was successfully updated."
  #   redirect_to movie_path(@movie)
  # end

  # replaces the 'update' method in controller:
  def update
    @movie = Movie.find(params[:id])
    permitted = params[:movie].permit(:title,:rating,:release_date)
    if @movie.update(permitted)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render 'edit' # note, 'edit' template can access @movie's field values!
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end