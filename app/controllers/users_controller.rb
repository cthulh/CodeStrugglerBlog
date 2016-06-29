class UsersController < ApplicationController
  before_filter :authorize_admin

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @deleted_user = @user.name
    @user.destroy
    redirect_to users_path, alert: "Successfully deleted user: #{@deleted_user}."
  end

  private

  def authorize_admin
    user = current_user
    if User.count==0
      return
    else
      return if user==nil
      return unless !user.role=="admin"
      redirect_to root_path, alert: 'Access denied!'
    end
  end

  def user_params
    params.require(:user).permit(:role, :name, :email, :password, :confirmed_password)
  end
end