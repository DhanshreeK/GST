class ManageUsersController < ApplicationController
  def index
    @users = User.all
  end

  # create new object of User
  # this method is used when user Sign_up for system
  def new
    @user = User.new
  end

  # create User object and pass required parameters
  # from private method user_params and
  # create action is saving our new User to the database.
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:user] = t('user_create')
      redirect_to dashboard_home_index_path
    else
      render 'new'
    end
  end

  # find User from database which we have selected,
  # and find that user information like username,name,role,email
  def show
    @user = User.load(params[:id])
    @student = @user.student
    @employee = User.where(role: 'Employee').take
  end

  # find User from database which we have type in text box
  def search
    @users ||= User.search_user(params[:search])
    authorize! :read, @user
  end

  # find User which we want to edit and pass it to update method
  # and perform authorization
  def edit
    @user = User.load(params[:id])
  end

  # upadate method update a User,
  # and it accepts a hash containing the attributes that you want to update.
  # and perform authorization
  def update
    @user = User.load(params[:id])
    if @user.update(user_params)
      flash[:notice] = t('user_update')
      redirect_to dashboard_home_index_path
    else
      render 'edit'
    end
  end

  # find User which we want to change password and
  # pass it to update_password method
  # and perform authorization
  def change_password
    @user = User.load(params[:id])
  end

  # update_password method update a User Password,
  # and it accepts a hash containing the attributes that you want to update.
  # and perform authorization
  def update_password
    @user = User.load(params[:id])
    if @user.update(user_params)
      flash[:notice] = t('pass_change')
      redirect_to dashboard_home_index_path
    else
      render 'change_password'
    end
  end


  # find User which we want to destroy,
  # destroy method deleting that User from the
  # database and perform authorization
  def destroy
    @user = User.load(params[:id])
    @user.destroy
    flash[:user_delete] = t('user_delete')
    redirect_to users_path
  end

  private

  # this private methods tell us exactly which parameters are allowed
  # into our controller actions.
  def user_params
    params.require(:user).permit!
  end
end