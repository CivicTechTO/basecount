class HeadcountsController < ApplicationController
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
    # TODO: does the incoming arg come through string or symbol?
    puts 'room'
    puts headcount_params[:room_id]
    # headcount_params['capacity'] = 


    headcount_params['recorded_at'] = Time.now
    
    @headcount = Headcount.new(headcount_params)

    if @headcount.save
      render :show, status: :created, location: @headcount
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /headcounts/1
  # PATCH/PUT /headcounts/1.json
  def update
    if @headcount.update(headcount_params)
      render :show, status: :ok, location: @headcount
    else
      render json: @headcount.errors, status: :unprocessable_entity
    end
  end

  # DELETE /headcounts/1
  # DELETE /headcounts/1.json
  def destroy
    @headcount.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_headcount
      @headcount = Headcount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def headcount_params
      params.fetch(:headcount, {})
    end
end
