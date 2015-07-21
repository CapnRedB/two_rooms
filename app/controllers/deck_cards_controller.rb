class DeckCardsController < ApplicationController
  before_action :set_deck, only: [:new, :create]
  before_action :set_deck_card, only: [:show, :edit, :update, :destroy]


  # GET /deck_cards/1
  # GET /deck_cards/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @deck_card, serializer: DeckCardDetailSerializer }
    end
  end

  # GET /decks/new
  def new
    @deck_card = @deck.deck_cards.new
  end

  # GET /decks/1/edit
  def edit
  end

  # POST /decks
  # POST /decks.json
  def create
    @deck = @deck.deck_cards.new(deck_params)
    # @deck = Deck.new(deck_params)

    respond_to do |format|
      if @deck.save
        format.html { redirect_to @deck, notice: 'Deck was successfully created.' }
        # format.json { render :show, status: :created, location: @deck }
        format.json { render json: @deck, status: :created }
      else
        format.html { render :new }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decks/1
  # PATCH/PUT /decks/1.json
  def update
    if @deck_card.deck.user == current_user or current_user.is_admin?
      respond_to do |format|
        if @deck_card.update(deck_card_params)
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
    @deck_card.destroy
    respond_to do |format|
      format.html { redirect_to decks_url, notice: 'Deck was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_deck_card
      @deck_card = DeckCard.find(params[:id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_deck
      @deck = Deck.find(params[:deck_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deck_card_params
      params.require(:deck_card).permit(:deck_id, :card_id, :affiliation)
    end

end