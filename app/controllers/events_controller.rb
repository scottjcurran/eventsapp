class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,except: [:index, :show]
  #before_action :authorize_owner!, only: [:edit, :update, :destroy]

  def index
    @events = Event.order(created_at: :desc)
    authorize @events, :index?
  end

  def show
    authorize @event, :show?
  end

  def new
    @event = Event.new
  end

  def new
    @event = Event.new

    authorize @event, :new?
  end

  def create
    @event = Event.new(event_params)

    authorize @event, :create?
    @event.organizer = current_user

    if @event.save
      flash[:notice] = "Event created!"
      redirect_to @event
    else
      flash.now[:alert] = "Event not created"
      render "new"
    end
  end

  def edit
    authorize @event, :edit?
  end

  def update
    authorize @event, :update?
    if @event.update(event_params)
      flash[:notice] = "Event Updated"
      redirect_to @event
    else
      flash.now[:alert] = "Event not Updated"
      render "edit"
    end
  end

  def destroy
     authorize @event, :destroy?
    @event.destroy
    redirect_to events_url
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  #def authorize_owner!
    #authenticate_user!

    #unless @event.organizer == current_user
      #flash[:alert] = "You do not have permission to '#{action_name}' the '#{@event.title.upcase}' event.  You can only update events you created"
        #redirect_to events_path
  end
