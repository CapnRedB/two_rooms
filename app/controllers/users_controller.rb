class UsersController < ApplicationController
  #before_filter :authenticate_user_from_token!, only: [:edit, :update]
  #before_action :set_user, only: [:show, :edit, :update, :finish_signup, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to @user, notice: "Your profile was successfully updated."}
        format.json { render json: {}, status: :ok}
      else
        format.html { render action: 'edit' }
        format.json { render json: {errors: @user.errors}, status: :unprocessable_entity }
      end
    end
  end

  # def finish_signup
  #   if request.patch? && params[:user]
  #     if @user.update(user_params)
  #       @user.skip_reconfirmation! if @user.respond_to?(:skip_reconfirmation!)
  #       sign_in(@user, bypass: true)
  #       redirect_to @user, notice: "Your profile was successfully updated."
  #     else
  #       @show_errors = true
  #     end
  #   end
  # end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessable = [ :name, :email ]
    accessable << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessable)
  end
end