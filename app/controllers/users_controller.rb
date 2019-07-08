class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @micropost = current_user.microposts.build if logged_in?
    @microposts = @user.microposts.order(created_at: :desc).paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそPPOの世界へ。 楽しんでいってくれよな！"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが変更されたぞ"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーが削除されたぞ"
    redirect_to users_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user)
        flash[:danger] = "おっと、そこは閲覧権限がないみたいだな"
        redirect_to(root_url)
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
