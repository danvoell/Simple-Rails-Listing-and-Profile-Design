class PostsController < ApplicationController
  
 before_filter :authenticate_user!, except: [:index, :show]
  
  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
     else
      @posts = Post.find_with_reputation(:votes, :all, order: "votes desc")
      end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
end


  # GET /posts/1
  # GET /posts/1.json
  def show
  @post = Post.find(params[:id])
  @commentable = @post
  @comments = @commentable.comments
  @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    authorize! :edit, @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

def vote
  value = params[:type] == "up" ? 1 : -1
  @post = Post.find(params[:id])
  @post.add_or_update_evaluation(:votes, value, current_user)
  redirect_to :back, notice: "Thank you for voting"
end

def tweet_text
  @tweet_text = URI.escape "#{post_title} via #{username}"
end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
