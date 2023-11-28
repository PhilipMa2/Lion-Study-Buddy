class HomeController < ApplicationController
    # before_action :require_student, only: [:new, :create]
    def index
      @groups = Group.all
    end
end
  