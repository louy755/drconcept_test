class PaysController < ApplicationController
  def index
    @pays = Pay.all
  end

  def show
    @pay= Pay.find(params[:id])
  end

  def create
    @person = Person.find(params[:person_id])
    @pay = @person.pays.build(pay_params)
    @pay.save
    respond_to do |format|
      format.html { redirect_to @person, success: 'Amount was successfully Created.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @pay = Pay.find(params[:id])
    @pay.destroy
    respond_to do |format|
      format.html { redirect_to @pay.person, warning: 'Amount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def pay_params
    params.require(:pay).permit(:method, :amount)
  end
end
