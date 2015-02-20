class SwapsController < ApplicationController
  before_action :set_round
  before_action :set_swap, only: [:show, :edit, :update, :destroy]

  # GET /swaps
  # GET /swaps.json
  def index
    @swaps = @round.swaps
  end

  # GET /swaps/1
  # GET /swaps/1.json
  def show
  end

  # GET /swaps/new
  def new
    prev_max = 5
    prev_max = @round.swaps.last.player_max unless @round.swaps.empty?
    @swap = @round.swaps.new
    @swap.player_min = prev_max + 1
    @swap.player_max = prev_max + 2
    @swap.count = 1
  end

  # GET /swaps/1/edit
  def edit
  end

  # POST /swaps
  # POST /swaps.json
  def create
    @swap = @round.swaps.new(swap_params)

    respond_to do |format|
      if @swap.save
        format.html { redirect_to round_swaps_path(@round), notice: 'Swap was successfully created.' }
        format.json { render :show, status: :created, location: @swap }
      else
        format.html { render :new }
        format.json { render json: @swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swaps/1
  # PATCH/PUT /swaps/1.json
  def update
    respond_to do |format|
      if @swap.update(swap_params)
        format.html { redirect_to round_swaps_path(@round), notice: 'Swap was successfully updated.' }
        format.json { render :show, status: :ok, location: @swap }
      else
        format.html { render :edit }
        format.json { render json: @swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swaps/1
  # DELETE /swaps/1.json
  def destroy
    @swap.destroy
    respond_to do |format|
      format.html { redirect_to round_swaps_url(@round), notice: 'Swap was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:round_id])
    end

    def set_swap
      @swap = Swap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def swap_params
      params.require(:swap).permit(:round_id, :player_min, :player_max, :count)
    end
end
