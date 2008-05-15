class GuessesController < ApplicationController
  before_filter :load_target_user, :only => [:new, :create, :edit, :update]
  before_filter :ensure_not_current_user, :only => [:new, :edit, :update]
  attr_reader :target_user

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
    @receiving_user = User.find(params[:user_id])
  end

  # POST /users
  # POST /users.xml
  def create
    @guess = Guess.new((params[:guess]).merge({:guessing_user => current_user, :receiving_user => target_user }))

    respond_to do |format|
      if @guess.save
        flash[:notice] = 'Guess was successfully created.'
        format.html { redirect_to(user_guess_url(target_user, @guess)) }
        format.xml  { render :xml => @guess, :status => :created, :location => @guess }
      else
        flash[:error] = @guess.errors.collect{|err| "<div>#{err.to_s}</div>"}
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
      if @guess.update_attributes(params[:guess])
        flash[:notice] = 'Guess was successfully updated.'
        format.html { redirect_to(user_guess_url(target_user, @guess)) }
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

  private
  def load_target_user
    @target_user = User.find(params[:user_id])
  end

  def ensure_not_current_user
    @receiving_user = User.find(params[:user_id])
    if @receiving_user == current_user
      flash[:error] = 'Sidu sez: She who guesses at her own salary must eat many beans until she recognizes her folly.'
      redirect_to(:controller => :users, :action => :index)
      return
    end
  end
end
