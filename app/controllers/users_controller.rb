class UsersController < ApplicationController

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
    authorize! :create, @user
  end

  def new
    @user = User.new
    authorize! :new, @user
  end

  def index
    @users = User.all
    authorize! :index, @user
  end

  def show
    @user = User.find(params[:id])
    authorize! :show, @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
    authorize! :update, @user
  end

  def edit
    @user = User.find(params[:id])
    authorize! :edit, @user
  end

  def destroy
    user = User.find(params[:id])
    deleted_user = user.name
    user.destroy
    redirect_to users_path, alert: "Successfully deleted user: #{deleted_user}."
    authorize! :destroy, user
  end

  private

  def user_params
    params.require(:user).permit(:role, :name, :email, :password)
  end
end