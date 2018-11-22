class HomeController < ApplicationController
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true)
  end

  def terms
  end

  def privacy
  end

  def search
    @movies = Movie.ransack(name_cont:params[:q]).result(distinct: true)
    @directors = Director.ransack(name_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json {
        @movies = @movies.limit(5)
        @directors = @directors.limit(5)
      }
    end
  end
end
