class DecksController < ApplicationController
  before_action :set_deck, only: [:show, :edit, :update, :destroy]

  skip_before_filter :authenticate_user_from_token!, only: [:index, :show]
  skip_before_filter :authenticate_user!, only: [:index, :show]

  # GET /decks
  # GET /decks.json
  def index
    @decks = Deck.all
    respond_to do |format|
      format.html 
      format.json { render json: @decks }
    end
  end

  # GET /decks/1
  # GET /decks/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @deck }
    end
  end

  # GET /decks/new
  def new
    @deck = Deck.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = current_user.decks.new(deck_params)
    # @deck = Deck.new(deck_params)

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        # format.json { render :show, status: :created, location: @deck }
        format.json { render json: @deck, status: :created }
      else
        format.html { render :new }
        format.json { render json: { errors: @deck.errors}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    if @deck.user == current_user or current_user.is_admin?
      respond_to do |format|
        if @deck.update(deck_params)
          format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
          format.json { render json: @deck, status: :ok}
        else
          format.html { render :edit }
          format.json { render json: @deck.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @deck, status: :unauthorized }
      end
    end
  end

  # DELETE /decks/1
  # DELETE /decks/1.json
  def destroy
    @deck.destroy
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_params
      params.require(:deck).permit(:user_id, :name, :description, :bury)
    end
end
