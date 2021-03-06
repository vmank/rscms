class PostsController < ApplicationController
  before_action :set_post, only: %w[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if PostsPolicy.show?(current_user, @post)
			render :show
		else
      render "generic/unauthorized"
		end
  end

  # GET /posts/new
  def new
    if PostsPolicy.new?(current_user)
			@post = Post.new
		else
      render "generic/unauthorized"
		end
  end

  # GET /posts/1/edit
  def edit
    if PostsPolicy.edit?(current_user, @post)
			render :edit
		else
      render "generic/unauthorized"
		end
  end

  # POST /posts
  # POST /posts.json
  def create
    if PostsPolicy.create?(current_user)

      @post = current_user.posts.build(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end

    else
      render "generic/unauthorized"
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if PostsPolicy.update?(current_user, @post)

      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end

    else
      render "generic/unauthorized"
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if PostsPolicy.destroy?(current_user)

      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end

    else
      render "generic/unauthorized"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :status)
    end
end
