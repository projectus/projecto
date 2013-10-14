class MainController < ApplicationController
	
  def index
    @projects = Project.all
  end

  def about
  end

  def landing
	end
end
