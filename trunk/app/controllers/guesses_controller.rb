class GuesssController < ApplicationController
  # GET /thought_workers
  # GET /thought_workers.xml
  def index
    @guesses = Guess.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guesses }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @guess = Guess.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guess }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @guess = Guess.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guess }
    end
  end

  # GET /users/1/edit
  def edit
    @guess = Guess.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @guess = Guess.new(params[:thought_worker])

    respond_to do |format|
      if @guess.save
        flash[:notice] = 'Guess was successfully created.'
        format.html { redirect_to(@guess) }
        format.xml  { render :xml => @guess, :status => :created, :location => @guess }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guess.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @guess = Guess.find(params[:id])

    respond_to do |format|
      if @guess.update_attributes(params[:thought_worker])
        flash[:notice] = 'Guess was successfully updated.'
        format.html { redirect_to(@guess) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guess.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @guess = Guess.find(params[:id])
    @guess.destroy

    respond_to do |format|
      format.html { redirect_to(thought_workers_url) }
      format.xml  { head :ok }
    end
  end
end
