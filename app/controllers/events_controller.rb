class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index

    current_user
    # @event_current_user = Event.all
    # .participants
    # .find(current_user.id)
    # @current_user_events

    @events = Event.all
    @user_events_participations = Participation.find_by(participant_id: current_user.id)
    @user_event_attendee = @user_events_participations.event
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @participants = @event.participants
    @gift_exchange = GiftExchange.find(params[:id])
    @wishlist = Wishlist.find_by(user_id: @gift_exchange.sender.id)
  end

  # GET /events/new
  def new
    @event = Event.new
    3.times do
      @event.participants.new
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.create_pairs
    3.times { @event.participants << User.find_by(email: params[:email]) }
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :suggested_budget, :creator_id, participants_attributes: [:id,:email])
    end
end
