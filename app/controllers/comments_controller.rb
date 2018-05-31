class CommentsController < ApplicationController
	before_action :set_comment, only: [:edit, :update, :destroy]
	include ApplicationHelper

	def index
    	@comments = Comment.all
  	end

	def edit
		@blog_post = BlogPost.find(@comment.blog_post_id)
		no_access_visitors(current_user, @comment)
	end

	def show
  	end

	def new
    	@comment = Comment.new
  	end

	# def create
	# 	@comment = Comment.new(comment_params)

	# 	respond_to do |format|
	# 		if @comment.save
	# 			format.html { redirect_to blog_post_url(id: @comment.blog_post_id), notice: "Comment successfully created" }
	# 		else
	# 			format.html { redirect_back fallback_location: root_path }
	# 		end
	# 	end
	# end
	def create
		@blog_post = BlogPost.find(params[:blog_post_id])
		@comment = @blog_post.comments.create(comment_params)
		redirect_to blog_post_path(@blog_post)		
	end
	def destroy
		@blog_post = BlogPost.find(params[:blog_post_id])
		@comment = @blog_post.comments.find(params[:id])
  		@comment.destroy
  		redirect_to blog_posts_path(@blog_post)
	end
	def update
		@blog_post = BlogPost.find(params[:id])
		if @comment.update(comment_params)
			redirect_to blog_post_url(id: @comment.blog_post_id)
		else
			render 'edit'
		end
	end

	# def destroy
	# 	@comment.destroy

	# 	respond_to do |format|
	# 		format.html { redirect_to blog_post_url(id: @comment.blog_post_id), notice: "Comment successfully deleted"}
	# 	end
	# end
	private def comment_params
		params.require(:comment).permit(:user_id, :comment_entry, :blog_post_id)
	end
	
	private def set_comment
		@comment = Comment.find(params[:id])
	end
end
