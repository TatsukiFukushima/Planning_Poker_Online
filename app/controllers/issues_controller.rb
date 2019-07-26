class IssuesController < ApplicationController
  def index
    @issues = Kaminari.paginate_array(Issue.all.order(created_at: :desc)).page(params[:page]).per(5)
    session.delete(:forwarding_url) if session[:forwarding_url]
  end

  def new
    set_return_url
    @issue = Issue.new
  end

  def edit
    set_return_url
    @issue = Issue.find(params[:id])
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.update_attributes(issue_params)
      flash[:success] = "issueの情報が変更されたぞ"
      redirect_back_or issues_url
    else
      render 'edit'
    end
  end

  def create
    @issue = Issue.new(issue_params)
    if @issue.save
      flash[:success] = "issueを作成したぞ"
      redirect_to issues_url
    else
      render 'new'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:success] = "issueが削除されたぞ"
    redirect_to issues_url
  end

  def import
    set_return_url
    @issue = Issue.new
  end

  def import_create
    client = Octokit::Client.new access_token: "2ff1e37b20222303d6b81a3f281d42971d281bd7"
    begin
      issues = client.issues(params[:repo])
      issues.each do |issue|
        Issue.create(name: issue.title, about: issue.body)
      end
      flash[:success] = "issueを作成したぞ"
      redirect_to issues_url
    rescue
      flash[:danger] = "リポジトリ名が間違ってるみたいだぞ"
      redirect_to issues_import_path
    end
  end

  private
    def issue_params
      params.require(:issue).permit(:name, :about, :point)
    end

    def set_return_url
      @return_url = session[:forwarding_url] || issues_path
    end
end
