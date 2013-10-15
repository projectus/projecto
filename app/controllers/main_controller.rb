class MainController < ApplicationController
	
  def index
    @projects = Project.all
  end

  def about
  end

  def landing
	  @beta_user = BetaUser.new
	end
end
