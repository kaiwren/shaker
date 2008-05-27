class WatchersController < ApplicationController

  # POST /users
  # POST /users.xml
  def create
    unless current_user.id.to_s == params[:listening_user]
      render :text => 'stop hacking!'
      return
    end
    @watcher = Watcher.new(:target_user_id => params[:target_user], :listening_user_id => params[:listening_user])

    respond_to do |format|
      if @watcher.save
        format.html { render :partial => "created" }
      else
        format.html { render :text => "already watching!" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @watcher = Watcher.find(params[:id])
    unless @watcher.listening_user == current_user
      render :text => 'stop hacking!'
      return
    end
    @watcher.destroy

    respond_to do |format|
      format.html { render :partial => "destroyed" }
    end
  end
end
