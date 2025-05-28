class IssuesController < ApplicationController
  before_action :set_project
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = @project.issues.recent
  end

  def show
  end

  def new
    @issue = @project.issues.new
  end

  def edit
  end

  def create
    @issue = @project.issues.new(issue_params)

    if @issue.save
      redirect_to project_issue_path(@project, @issue), notice: "Issue was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to project_issue_path(@project, @issue), notice: "Issue was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @issue.destroy
    redirect_to project_issues_url(@project), notice: "Issue was successfully destroyed."
  end

  def reports
    @status_counts = @project.issues.group(:status).count
    @priority_counts = @project.issues.group(:priority).count
  end

  def export
    @issues = @project.issues.recent

    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=issues_#{Date.today}.xlsx"
      end
      format.pdf do
        render pdf: "issues_report_#{Date.today}",
               template: "issues/export",
               formats: [:html],
               disposition: :attachment
      end
    end
  end

  def export
    @issues = @project.issues.recent

    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=#{@project.title.parameterize}_issues_#{Date.today}.xlsx"
      end
      format.pdf do
        render pdf: "#{@project.title.parameterize}_issues_report_#{Date.today}",
              template: "issues/export",
              formats: [:html],
              disposition: :attachment,
              layout: 'pdf'
      end
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_issue
      @issue = @project.issues.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:title, :status, :priority)
    end
end
