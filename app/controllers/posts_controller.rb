class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :new, :update, :destroy]

	def index
		@title = "Blog of a Coding Struggler"
		if params[:q]
			search_term = params[:q]
			unless Rails.env.test?
				@posts = Post.with_tag(search_term).page(params[:page])
			end
		else
		@posts = Post.page(params[:page]).order("created_at DESC")
		end
	end

	def new
		@post = Post.new
		authorize! :new, @post
	end

	def show
		@post = Post.find(params[:id])
		@title = @post.title
	end

	def edit
		@post = Post.find(params[:id])
		@title = 'Edit a post'
		authorize! :edit, @post
	end

	def update
		@post = Post.find(params[:id])
		
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
		authorize! :update, @post
	end

	def create
		@user = current_user
		@post = @user.posts.build(post_params)
		
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
		authorize! :create, @post
	end

	def destroy
		post = Post.find(params[:id])
		post.destroy

		redirect_to root_path
		authorize! :destroy, post
	end

	private
		def post_params
			params.require(:post).permit(:title, :body, :tags)
		end
end
