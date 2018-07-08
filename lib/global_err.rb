module GlobalErr

  # class InternalError
  #   def new(message)
  #     @message = message
  #   end
  # end

  ERRORS = {
    invalid_role: 'Role was invalid',
    invalid_user: 'User was invalid',
    site_org_set: 'Site or Org scope must be set if setting a scoped role',
    must_be_org: 'Argument must be an org',
    must_be_site: 'Argument must be an site',
  }

  # private_constant :InternalError
end