class PostsController < ApplicationController
  def index
    # if enter url like http://localhost:3000/tags/motivation then filter
    if params[:tag]
      #@posts = Post.tagged_with(params[:tag])
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
      authorize @posts
    else
      @posts = Post.paginate(page: params[:page], per_page: 10)
      authorize @posts
    end
  end

  def latest
    @posts = Post.order("created_at DESC").paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    # authorize checks the policy on new post resources 
    # and will throw exception if policy not met (e.g. no user logged in)
    authorize @post 
    
  end

  def create
    # Build post object
    @post = current_user.posts.build(post_params)
    
    # Associate all sumpoints with current user
    @post.sumpoints.each do |sumpoint|
      sumpoint.user = current_user
    end

    # Authorise the post
    authorize @post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    name = @post.title

    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_path
    else
      flash[:error] = "There was an error deleting the post."
      render :show 
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id, :url, sumpoints_attributes: [:id, :body, :tag_list, :_destroy])
  end

end
