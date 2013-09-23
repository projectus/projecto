class MainController < ApplicationController

  def index
    @projects = Project.find(:all)
  end

  def about
  end
end
