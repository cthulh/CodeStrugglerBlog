class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :new, :update, :destroy]

	def index
		@posts = Post.all.order("created_at DESC")
		@title = "Blog of a Code Struggler"
	end

	def new
		@post = Post.new
	end

	def show
		@post = Post.find(params[:id])
		@title = @post.title
	end

	def edit
		@post = Post.find(params[:id])
		@title = 'Edit a post'
	end

	def update
		@post = Post.find(params[:id])
		
		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def create
		@user = current_user
		@post = @user.posts.build(post_params)
		
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to root_path
	end

	private
		def post_params
			params.require(:post).permit(:title, :body)
		end
end
