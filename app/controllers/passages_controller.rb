class PassagesController < ApplicationController
  # GET /passages
  # GET /passages.json
  def index
    @passages = Passage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @passages }
    end
  end

  # GET /passages/1
  # GET /passages/1.json
  def show
    @passage = Passage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @passage }
    end
  end

  # GET /passages/new
  # GET /passages/new.json
  def new
    @passage = Passage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @passage }
    end
  end

  # GET /passages/1/edit
  def edit
    @passage = Passage.find(params[:id])
    authenticate_content_owner(@passage.user_id)
    
    respond_to do |format|
      format.html # edit.html.erb
      format.js{}
      format.json { render json: @passage }
    end
  end

  # POST /passages
  # POST /passages.json
  def create
    @passage = Passage.new(params[:passage])
    if user_signed_in?
      @passage.user_id = current_user.id

      if params[:passage][:private]
        @permission = Permission.create()
        params[:user_ids].each do |user_id|
          @permission.users << User.find(user_id)
        end
        @permission.save
        @passage.permission = @permission
      end
    end
    @passage.scripture = render_bible_verses(@passage.bible)

    respond_to do |format|
      if @passage.save
        format.html { redirect_to @passage, notice: 'Passage was successfully created.' }
        format.json { render json: @passage, status: :created, location: @passage }
      else
        format.html { render action: "new" }
        format.json { render json: @passage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /passages/1
  # PUT /passages/1.json
  def update
    @passage = Passage.find(params[:id])
    
    authenticate_content_owner(@passage.user_id)
    
    @passage.update_attributes(params[:passage])
    @passage.scripture = render_bible_verses(@passage.bible)
      
    respond_to do |format|
      if @passage.save
        format.html { redirect_to @passage, notice: 'Passage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @passage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passages/1
  # DELETE /passages/1.json
  def destroy
    @passage = Passage.find(params[:id])
    
    authenticate_content_owner(@passage.user_id)

    @passage.destroy
    respond_to do |format|
      format.html { redirect_to passages_url }
      format.json { head :no_content }
    end
  end
end
