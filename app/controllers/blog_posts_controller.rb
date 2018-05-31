class BlogPostsController < ApplicationController

	before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
	include ApplicationHelper

	def user_posts
		@user = User.find_by(username: params[:name])
	end

	def index
		@blog_posts = BlogPost.all.page(params[:page])
	end

	def show
		# @comment = Comment.new
	end

	def edit
		no_access_visitors(current_user, @blog_post)
	end

	def new
		@blog_post = BlogPost.new
	end

	def create
		@blog_post = BlogPost.new(blog_post_params)

		respond_to do |format|
			if @blog_post.save
				format.html { redirect_to blog_post_url(@blog_post), notice: "Blog post successfully created" }
			else
				format.html { render :new }
			end
		end
	end

	def update
		@blog_post = BlogPost.find(params[:id])

		if (@blog_post.update(blog_post_params))
			redirect_to @blog_post, notice: "Blog post successfully updated" 
		else
			render 'edit'
		end
	end

	def destroy
		@blog_post.destroy

		respond_to do |format|
			format.html { redirect_to blog_posts_url, notice: "Blog post successfully deleted"}
		end
	end

	private

	def set_blog_post
		@blog_post = BlogPost.find(params[:id])
	end

	def blog_post_params
		params.require(:blog_post).permit(:title, :blog_entry, :user_id)
	end
end
