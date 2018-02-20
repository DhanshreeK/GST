class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  # GET /parties.json
  def index
    if current_user.role == "ChartedAccountant"
     @parties = current_user.charted_accountant.parties
   elsif current_user.role == "SuperAdmin"
     @parties = Party.all
     @general_setting = GeneralSetting.first
     if params[:param1].present? && params[:param1] == 'false'
      party = Party.load(params[:id])
      party.update!(party_status: 'true')
    elsif params[:param1].present? && params[:param1] == 'true'
       party = Party.load(params[:id])
      party.update!(party_status: 'false')  
    end
   else
     @parties = current_user.party
   end
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    @general_setting = GeneralSetting.first
  end

  # GET /parties/new
  def new
    @party = Party.new
    @party.party_no = Party.set_party_no
    @general_setting = GeneralSetting.first
  end

  # GET /parties/1/edit
  def edit
    @general_setting = GeneralSetting.first
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.new(party_params)
      if current_user.role == 'ChartedAccountant'
        @party.update!(:charted_accountant_id => current_user.charted_accountant.id) 
        # User.create!(first_name: @party.party_name, username: @party.email, party_id: @party.id, password: @party.party_no, role: 'Party',email: @party.email)
      else
        @party.save
      if current_user.role == 'Party'
        current_user.party_id = @party.id
        current_user.save
      end
     end
    @party.save
     
      redirect_to @party
    end
  

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
      @general_setting = GeneralSetting.first
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.require(:party).permit(:party_type,:joining_date,:due_date,:contact_no ,:alternate_contact_no ,:composite, :regular,:image,:email,:party_no,:party_name, :party_gstin_no, :party_arn_no, :party_address, :place_of_supply, :commodity_name, :tarrif_no, :hsn_no, :rate_of_tax, :name_service, :service_acc_code, :party_pan_no, :state_name, :state_code, :ca_name, :ca_contact)
    end
end
