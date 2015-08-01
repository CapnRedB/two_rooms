class GameSwapsController < ApplicationController
  before_action :set_game_swap, only: [:show, :edit, :update, :destroy]

  # GET /game_swaps
  # GET /game_swaps.json
  def index
    @game_swaps = GameSwap.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_swaps }
    end
  end

  # GET /game_swaps/1
  # GET /game_swaps/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_swap }
    end
  end

  # GET /game_swaps/new
  def new
    @game_swap = GameSwap.new
  end

  # GET /game_swaps/1/edit
  def edit
  end

  # POST /game_swaps
  # POST /game_swaps.json
  def create
    @game_swap = GameSwap.new(game_swap_params)

    respond_to do |format|
      if @game_swap.save
        format.html { redirect_to @game_swap, notice: 'Game swap was successfully created.' }
        format.json { render json: @game_swap, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @game_swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_swaps/1
  # PATCH/PUT /game_swaps/1.json
  def update
    respond_to do |format|
      if @game_swap.update(game_swap_params)
        format.html { redirect_to @game_swap, notice: 'Game swap was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game_swap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_swaps/1
  # DELETE /game_swaps/1.json
  def destroy
    @game_swap.destroy
    respond_to do |format|
      format.html { redirect_to game_swaps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_swap
      @game_swap = GameSwap.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_swap_params
      params.require(:game_swap).permit(:game_id, :round_id, :sequence, :a_to_b_id, :b_to_a_id)
    end
end
