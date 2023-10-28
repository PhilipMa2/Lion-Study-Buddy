class HomeController < ApplicationController
    # before_action :require_student, only: [:new, :create]
    def index
      @posts = Post.all
    end
end
  