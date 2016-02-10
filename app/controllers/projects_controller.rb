class ProjectsController < ApplicationController
  before_action :get_project, only: [:show, :edit, :update, :destroy, :inactive, :active]

  def new
    @project = Project.new
  end

  def index
    @inactive_projects = Project.where(active: false)
    @active_projects = Project.where(active: true)
  end

  def show
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def active
    @project.update_attribute(:active, true)
    redirect_to projects_path
  end

  def inactive
    @project.update_attribute(:active, false)
    redirect_to projects_path
  end

  private

  def get_project
    @project =Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :active, :user_id)
  end
end