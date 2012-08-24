class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

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
      format.js{}
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    continue = authenticate_content_owner(@post.user_id)
    
    if continue
      @index = params[:index]
      respond_to do |format|
        format.html # edit.html.erb
        format.js{}
        format.json { render json: @post }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You're not authorized to do this! Please sign in as the content owner."}
      end
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    if user_signed_in?
      @post.user_id = current_user.id
    end
    @post.content = handle_bible_verse_tagging(@post.content)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post.passage, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    
    continue = authenticate_content_owner(@post.user_id)
    
    if continue
      @post.update_attributes(params[:post])
      @post.content = handle_bible_verse_tagging(@post.content)
      
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post.passage, notice: 'Post was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You're not authorized to do this! Please sign in as the content owner."}
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    
    @content_owner_ids = [@post.user_id, @post.passage.user_id]
    
    continue = authenticate_subcontent_owner(@content_owner_ids)
    
    if continue
      @post.destroy

      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You're not authorized to do this! Please sign in as the content owner."}
      end
    end
  end
end
