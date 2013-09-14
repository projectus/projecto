class ProjectProfilesController < ApplicationController
  before_action :set_project_profile, only: [:show, :about, :edit, :update]

  # GET /project_profiles/1
  # GET /project_profiles/1.json
  def show
	  # Show the news feed for the project
	  redirect_to project_news_posts_url(associated_project)
  end
	
	def about
	  @outline = @project_profile.outline
  end

  # GET /project_profiles/1/edit
  def edit
  end

  # PATCH/PUT /project_profiles/1
  # PATCH/PUT /project_profiles/1.json
  def update
    respond_to do |format|
      if @project_profile.update(project_profile_params)
        format.html { redirect_to @project_profile, notice: 'Project profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_profile
      @project_profile = ProjectProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_profile_params
      params.require(:project_profile).permit()
    end

    def associated_project
	    @project_profile.project
	  end
end
