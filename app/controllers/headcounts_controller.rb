
class HeadcountsController < ApplicationController
  include PermissionHelper
  before_action :set_headcount, only: [:show, :update, :destroy]

  # GET /headcounts
  # GET /headcounts.json
  def index
    @headcounts = Headcount.all
  end

  # GET /headcounts/1
  # GET /headcounts/1.json
  def show
  end

  # POST /headcounts
  # POST /headcounts.json
  def create
    room = Room.find_by_id(headcount_params[:room_id])
    return self.bad_request_json "Invalid room" if room.nil?
    
    # find site that the room belongs to
    p = Permissions.new({
      user: current_user,
      site: room.site
    })
    return self.unauthorized_json unless user_signed_in? and p.can_add_site_counts?

    # augment the parameters with expected values
    default_params = {
      recorded_at: Time.now,
      recorded_by: current_user,
      capacity: room.capacity,
    }
    
    @headcount = Headcount.new(headcount_params.merge default_params)

    if @headcount.save
      render :show, status: :created, location: @headcount
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /headcounts/1
  # PATCH/PUT /headcounts/1.json
  def update
    edit_window = Rails.application.config.headcount_edit_window_minutes

    # find site that the room belongs to
    p = Permissions.new({
      user: current_user,
      site: @headcount.room.site
    })
    return self.unauthorized_json unless user_signed_in? and p.can_add_site_counts?

    # ensure headcount isn't too old
    if @headcount.recorded_at < Time.now - edit_window.minutes
      return self.bad_request_json("Headcount cannot be updated after #{edit_window} minutes")
    end

    if @headcount.update(headcount_params)
      render :show, status: :ok, location: @headcount
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  # DELETE /headcounts/1
  # DELETE /headcounts/1.json
  # def destroy
  #   @headcount.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headcount
      @headcount = Headcount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def headcount_params
      params.require(:headcount).permit(
        :room_id,
        :occupancy
      )
    end
end
