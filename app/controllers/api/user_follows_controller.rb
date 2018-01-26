class Api::UserFollowsController < ApplicationController

  def create
    @userfollow = UserFollow.new
    @userfollow.followed_user_id = params[:followed_user_id]
    @userfollow.user_id = current_user.id

    if @userfollow.save
      @user = User.find_by(id: :followed_user_id)
      render "api/users/show", user: @user
    else
      render json: @userfollow.errors.full_messages
    end
  end

  def destroy
    @userfollow = User.find_by(followed_user_id: params[:id])
    @userfollow.user_id = current_user.id
    @userfollow.destroy!

    @user = User.find_by(id: params[:id])
    render "api/users/show", user: @user
  end


end
