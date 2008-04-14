class ThoughtWorkersController < ApplicationController
  # GET /thought_workers
  # GET /thought_workers.xml
  def index
    @thought_workers = ThoughtWorker.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thought_workers }
    end
  end

  # GET /thought_workers/1
  # GET /thought_workers/1.xml
  def show
    @thought_worker = ThoughtWorker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @thought_worker }
    end
  end

  # GET /thought_workers/new
  # GET /thought_workers/new.xml
  def new
    @thought_worker = ThoughtWorker.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @thought_worker }
    end
  end

  # GET /thought_workers/1/edit
  def edit
    @thought_worker = ThoughtWorker.find(params[:id])
  end

  # POST /thought_workers
  # POST /thought_workers.xml
  def create
    @thought_worker = ThoughtWorker.new(params[:thought_worker])

    respond_to do |format|
      if @thought_worker.save
        flash[:notice] = 'ThoughtWorker was successfully created.'
        format.html { redirect_to(@thought_worker) }
        format.xml  { render :xml => @thought_worker, :status => :created, :location => @thought_worker }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thought_worker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /thought_workers/1
  # PUT /thought_workers/1.xml
  def update
    @thought_worker = ThoughtWorker.find(params[:id])

    respond_to do |format|
      if @thought_worker.update_attributes(params[:thought_worker])
        flash[:notice] = 'ThoughtWorker was successfully updated.'
        format.html { redirect_to(@thought_worker) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thought_worker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thought_workers/1
  # DELETE /thought_workers/1.xml
  def destroy
    @thought_worker = ThoughtWorker.find(params[:id])
    @thought_worker.destroy

    respond_to do |format|
      format.html { redirect_to(thought_workers_url) }
      format.xml  { head :ok }
    end
  end
end
