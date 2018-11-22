class MoviesController < ApplicationController
  def show
    @movie = Movie.find_by(params[:id])
  end
end
