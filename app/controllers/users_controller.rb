class UsersController < ApplicationController

  def show
    @user = User.find_by_id(params[:id])
    return redirect_to '/' if !@user
  end
end