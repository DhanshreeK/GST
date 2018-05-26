class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @item = Item.new
    if current_user.role == 'Party'
      @items = current_user.items
    else
      @items = Item.all
    end
  end

  def load_item_data
    @item = Item.find_by_id(params[:item_id]).present? ? Item.find(params[:item_id]) : Item.unscoped.find_by_id(params[:item_id])
    render :json => [@item.rate, @item.cgst.to_f, @item.sgst.to_f, @item.item_code]
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @user = current_user
    respond_to do |format|
      if @item.save
        @item.update!(user_id: @user.id)
        format.html { redirect_to items_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to item_path, notice: 'Item was successfully updated.' }
        format.json { render :index, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_code, :unit_of_measure_id,:igst,:dogns, :item_hsn_no, :uom, :qty, :rate, :taxable_value,:cgst,:sgst)
    end
end
