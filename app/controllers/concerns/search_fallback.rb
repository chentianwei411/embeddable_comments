module SearchFallback
  extend ActiveSupport::Concern

  included do

    rescue_from ActiveRecord::RecordNotFound do |exception|
      @query = params[:id].gsub(/^[\w-]/, "")
      @episodes = Episode.where("name like ? OR slug like ?", "%#{@query}%", "%#{@query}%")
      render "episodes/error_search"
    end

  end
end
