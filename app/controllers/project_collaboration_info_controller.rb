class ProjectCollaborationInfoController < ApplicationController
  before_action :set_project

  helper_method :associated_project

  def collaborations
  end

  def applications
  end

  def invitations
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def associated_project
	    @project
	  end
end
