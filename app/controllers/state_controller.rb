class StateController < ApplicationController

  # GET /base_state
  def index
    users = {}
    if user_signed_in?
      users[current_user[:id]] = current_user.format_for_frontend
    end

    orgs = {}
    orgs[current_org[:id]] = current_org
    
    state = {
      loggedIn: user_signed_in?,
      appUser: user_signed_in? ? current_user.id : nil,
      appOrg: current_org[:id],
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