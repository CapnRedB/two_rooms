class GameLogsController < ApplicationController
  before_action :set_game

  # GET /game_logs
  # GET /game_logs.json
  def index
    @game_logs = @game.logs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_logs }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:game_id])
    end

end
