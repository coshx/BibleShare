class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    @index = params[:index]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
      format.js{}
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    continue = authenticate_content_owner(@comment.user_id)
    
    if continue
      @index = params[:index]
      respond_to do |format|
        format.html # edit.html.erb
        format.js{}
        format.json { render json: @comment }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You're not authorized to do this! Please sign in as the content owner."}
      end
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    if user_signed_in?
      @comment.user_id = current_user.id
    end
    @comment.content = handle_bible_verse_tagging(@comment.content)
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post.passage, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    
    continue = authenticate_content_owner(@comment.user_id)
    
    if continue
      @comment.update_attributes(params[:comment])
      @comment.content = handle_bible_verse_tagging(@comment.content)
      
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment.post.passage, notice: 'Comment was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "You're not authorized to do this! Please sign in as the content owner."}
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @content_owner_ids = [@comment.user_id, @comment.post.user_id]
    
    continue = authenticate_subcontent_owner(@content_owner_ids)
    
    if continue
      @comment.destroy

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
