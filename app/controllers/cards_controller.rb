class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.all

    respond_to do |format|
      format.html
      format.pdf { send_data Card.render, type: "application/pdf", disposition: "inline" }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def flip
    @card = Card.find(params[:card_id])
    flipped = @card.flip
    respond_to do |format|
      if flipped.save
        format.html { redirect_to flipped, notice: 'Card was successfully flipped.' }
        format.json { render :show, status: :created, location: flipped }
      else
        format.html { render :new }
        format.json { render json: flipped.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort
    order = params[:order].split(",")
    cur = 1
    order.each do |card_id|
      card = Card.find(card_id)
      unless card.nil?
        card.sort_order = cur 
        card.save
        cur += 1
      end
    end

    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card order updated.' }
      format.json { render json: { code: :sort_updated, message: "Card order updated."} }
    end

  end



  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:title, :subtitle, :short_desc, :long_desc, :color, :faction, :strategy, :url, :quantity)
    end
end
