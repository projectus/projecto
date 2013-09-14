class MainController < ApplicationController

  def index
  end

  def about
  end

  def s_projects
    @projects = Project.find(:all)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
