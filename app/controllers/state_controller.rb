class StateController < ApplicationController

  # GET /base_state
  def index
    users = {}
    if user_signed_in?
      users[current_user[:id]] = current_user.format_for_frontend
    end

    orgs = {}
    app_org = nil
    if current_org
      orgs[current_org[:id]] = current_org 
      app_org = current_org[:id]
    end
    
    state = {
      loggedIn: user_signed_in?,
      appUser: user_signed_in? ? current_user.id : nil,
      appOrg: app_org,
      permission_levels: Role.render_roles_for_frontend,
      sitePopulations: Site.population_codes_for_frontend,
      dbData: {
        sites: {},
        orgs: orgs,
        users: users
      }
    }
 
    render json: state
  end

end