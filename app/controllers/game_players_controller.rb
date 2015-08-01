class GamePlayersController < ApplicationController
  before_action :set_game_player, only: [:show, :edit, :update, :destroy]

  # GET /game_players
  # GET /game_players.json
  def index
    @game_players = GamePlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_players }
    end
  end

  # GET /game_players/1
  # GET /game_players/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_player }
    end
  end

  # GET /game_players/new
  def new
    @game_player = GamePlayer.new
  end

  # GET /game_players/1/edit
  def edit
  end

  # POST /game_players
  # POST /game_players.json
  def create
    @game_player = GamePlayer.new(game_player_params)

    respond_to do |format|
      if @game_player.save
        format.html { redirect_to @game_player, notice: 'Game player was successfully created.' }
        format.json { render json: @game_player, status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_players/1
  # PATCH/PUT /game_players/1.json
  def update
    respond_to do |format|
      if @game_player.update(game_player_params)
        format.html { redirect_to @game_player, notice: 'Game player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_players/1
  # DELETE /game_players/1.json
  def destroy
    @game_player.destroy
    respond_to do |format|
      format.html { redirect_to game_players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_player
      @game_player = GamePlayer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_player_params
      params.require(:game_player).permit(:game_id, :user_id, :card_id, :location, :leader, :voting_for_id)
    end
end
