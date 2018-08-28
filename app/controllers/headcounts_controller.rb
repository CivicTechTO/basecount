
class HeadcountsController < ApplicationController
  include PermissionHelper
  before_action :set_headcount, only: [:show, :update, :destroy]


  # GET /headcounts/1
  # GET /headcounts/1.json
  def show
    return self.unauthorized_json unless user_signed_in? and current_user.can_view_global_counts?
    render json: @headcount.for_frontend
  end

  # POST /headcounts
  # POST /headcounts.json
  def create
    site = Site.find_by_id(headcount_params[:site_id])
    return self.bad_request_json "Invalid site" if site.nil?
    
    return self.unauthorized_json unless user_signed_in? and current_user.can_add_site_counts? site

    # augment the parameters with expected values
    default_params = {
      recorded_at: Time.now,
      recorded_by: current_user,
      capacity: site.default_capacity,
    }
    
    @headcount = Headcount.new(headcount_params.merge default_params)

    if @headcount.save
      render json: @headcount.for_frontend, status: 201
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /headcounts/1
  # PATCH/PUT /headcounts/1.json
  def update
    edit_window = Rails.application.config.headcount_edit_window_minutes

    return self.unauthorized_json unless user_signed_in? and current_user.can_add_site_counts? @headcount.site

    # ensure headcount isn't too old
    if @headcount.recorded_at < Time.now - edit_window.minutes
      return self.bad_request_json("Headcount cannot be updated after #{edit_window} minutes")
    end

    if @headcount.update(headcount_params)
      render json: @headcount.for_frontend, status: 200
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headcount
      @headcount = Headcount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def headcount_params
      params.require(:headcount).permit(
        :site_id,
        :occupancy
      )
    end
end
