class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :new, :update, :destroy]
	load_and_authorize_resource

	def create
		@comment = @post.comments.create(params[:comment].permit(:name,:body))

		redirect_to post_path(@post)
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end

end
