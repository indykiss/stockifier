class SessionsController < ApplicationController
  # before_action :set_session, only: [:show, :edit, :update, :destroy]

  # My sessions were kinda broken in datapond,
    # DEFINITELY NEED TO FIX
    # Problem in datapond is not having a sessions model maybe? s

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    session[:user_id] = @user.id

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @session.destroy
    redirect_to root_path
  end

end
