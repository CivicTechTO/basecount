class SitesController < ApplicationController
  include PermissionHelper
  before_action :set_site, only: [:show, :update, :destroy]

  # GET /sites
  # GET /sites.json
  def index
    @sites = Site.all
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
  end

  # POST /sites
  # POST /sites.json
  def create
    org = Org.find_by_id(site_params[:org_id])
    return self.bad_request_json "Invalid Org" if org.nil?

    
    return self.unauthorized_json unless user_signed_in? and user.can_manage_org_sites? org

    @site = Site.new(site_params)

    if @site.save
      render :show, status: :created, location: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    return self.unauthorized_json unless user_signed_in? and user.can_manage_site? @site
    
    if @site.update(site_params)
      render :show, status: :ok, location: @site
    else
      render json: @site.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.fetch(:site, {})
    end
end
