class SitesController < ApplicationController
  include PermissionHelper
  before_action :set_site, only: [:show, :update, :destroy, :users, :add_user, :edit_user, :remove_user, :headcounts]
  before_action :set_user, only: [:edit_user, :remove_user]

  # POST /api/sites/new
  def create
    org = Org.find_by_id(site_params[:general][:org_id])
    return self.bad_request_json "Invalid Org" if org.nil?
    return self.unauthorized_json unless user_signed_in? and current_user.can_manage_org_sites? org
    
    site_create_params = site_params[:general].merge( site_params[:services] )
    # convert populations
    
    @site = Site.new(site_create_params)

    if @site.save
      render json: @site, status: 201
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # GET /api/sites/:id
  def show
    self.not_implemented
  end


  # PUT /api/sites/:id
  def update
    return self.unauthorized_json unless user_signed_in? and current_user.can_manage_site?(@site)
    
    # TODO: need to auto geo-locate based on address
    
    if @site.update(site_params)
      render json: @site, status: 200
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # GET /sites/:id/users
  def users
    return self.unauthorized_json unless user_signed_in? and current_user.can_manage_site_users?(@site)
    
    render json: @site.users
  end

  # POST /sites/:id/users
  def add_user
    self.not_implemented
  end

  # PUT /sites/:id/users/:uid
  def edit_user
    self.not_implemented
  end

  # DELETE /sites/:id/users/:uid
  def remove_user
    self.not_implemented
  end

  # GET /sites/:id/headcounts
  def headcounts
    self.not_implemented
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      id = params[:id] || params[:general][:org_id]
      @site = Site.find_by_id(id)
      return self.not_found_json if @site.nil?
    end

    def set_user
      @user = User.find_by_id(params[:uid])
      return self.not_found_json if @user.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      general = params.require(:general).permit(
        :name,
        :address,
        :postal_code,
        :phone,
        :org_id
      )

      services = params.require(:services).permit(
        :service_text,
        :populations_served
      )

      # TODO: Schedule will be added in the future
      # schedule = params.require(:schedule).permit()

      { 
        general: general,
        services: services,
        # schedule: schedule 
      }
    end
end
