class ApplicationController < ActionController::Base  
  # TODO: probbaly need to make this better.
  def unauthorized_json msg = nil
    self.generic_request_error(403, msg)
  end

  def bad_request_json msg = nil
    self.generic_request_error(400,msg)
  end
  
  def generic_request_error code, msg
    json_to_return = {
      statusCode: code
    }
    unless msg.nil?
      json_to_return['message'] = msg
    end
    
    render json: json_to_return, status: code
  end
end
