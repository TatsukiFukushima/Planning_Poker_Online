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
    client = Octokit::Client.new access_token: ENV['ACCESS_TOKEN']
    begin
      issues = client.issues(params[:repo])
      exist_new_issue = false
      issues.each do |issue|
        new_issue = Issue.new(name: issue.title, about: issue.body)
        exist_new_issue = true if new_issue.save
      end
      exist_new_issue ? flash[:success] = "新しいissueをgithubから登録したぞ" : flash[:danger] = "新しく登録できるissueが無いみたいだな"
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
