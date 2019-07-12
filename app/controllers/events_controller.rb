class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Event created!"
      redirect_to @event
    else
      flash.now[:alert] = "Event not created"
      render "new"
    end
  end

  def show
  end

  def index
    @events = Event.all
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event Updated"
      redirect_to @event
    else
      flash.now[:alert] = "Event not Updated"
      render "edit"
    end
  end

  def destroy
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
end
