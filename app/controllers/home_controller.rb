class HomeController < ApplicationController
  def index
    @groups = Group.all

    if params[:capacity].present?
      @groups = @groups.where('capacity <= ?', params[:capacity].to_i)
    end

    if params[:course_search].present?
      search_term = "%#{params[:course_search].downcase}%"
      @groups = @groups.where('LOWER(course) LIKE ? OR LOWER(focus) LIKE ?', search_term, search_term)
    end
  end
end