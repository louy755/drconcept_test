class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def more
    @people = Person.all
    @goods = Good.all
    @pays = Pay.all
    @delivers = Deliver.all
  end
  def index
    @people = Person.all.order("created_at DESC")
    @goods = Good.all
    @pays = Pay.all
    @delivers = Deliver.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    respond_to do |format|
    format.html
      format.pdf do
        pdf = InvoicePdf.new(@person, view_context)
        send_data pdf.render, filename: "invoice_#{@person.phone}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /people/new
  def new
    @person = current_user.people.build
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = current_user.people.build(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, success: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, info: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, warning: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:name, :phone, :email, :address, :address2, :city,
      :state, :zip, :finance, :subtotal, :tax, :total, :user_id, :sale_rep, :cost)
    end
end
