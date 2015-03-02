class CardRelationshipsController < ApplicationController
  before_action :set_card_relationship, only: [:show, :edit, :update, :destroy]

  # GET /card_relationships
  # GET /card_relationships.json
  def index
    @card_relationships = CardRelationship.all
  end

  # GET /card_relationships/1
  # GET /card_relationships/1.json
  def show
  end

  # GET /card_relationships/new
  def new
    @card_relationship = CardRelationship.new
  end

  # GET /card_relationships/1/edit
  def edit
  end

  # POST /card_relationships
  # POST /card_relationships.json
  def create
    @card_relationship = CardRelationship.new(card_relationship_params)

    respond_to do |format|
      if @card_relationship.save
        format.html { redirect_to @card_relationship, notice: 'Card relationship was successfully created.' }
        format.json { render :show, status: :created, location: @card_relationship }
      else
        format.html { render :new }
        format.json { render json: @card_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /card_relationships/1
  # PATCH/PUT /card_relationships/1.json
  def update
    respond_to do |format|
      if @card_relationship.update(card_relationship_params)
        format.html { redirect_to @card_relationship, notice: 'Card relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_relationship }
      else
        format.html { render :edit }
        format.json { render json: @card_relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /card_relationships/1
  # DELETE /card_relationships/1.json
  def destroy
    @card_relationship.destroy
    respond_to do |format|
      format.html { redirect_to card_relationships_url, notice: 'Card relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_relationship
      @card_relationship = CardRelationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_relationship_params
      params.require(:card_relationship).permit(:card_id, :to_id, :description)
    end
end
