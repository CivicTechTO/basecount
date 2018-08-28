class StateController < ApplicationController
  
  # GET /base_state
  def index
    testJson = {
      foo: "bar"
    }
 
    render json: testJson
  end

end