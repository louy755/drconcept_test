class DeliversController < ApplicationController
  def index
    @delivers = Deliver.all
  end

  def show
    @deliver= Deliver.find(params[:id])
  end

  def create
    @person = Person.find(params[:person_id])
    @deliver = @person.delivers.build(deliver_params)
    @deliver.save
    respond_to do |format|
        format.html { redirect_to @person, success: 'Amount was successfully Created.' }
        format.json { head :no_content }
    end
  end

  def destroy
    @deliver = Deliver.find(params[:id])
    @deliver.destroy
    respond_to do |format|
        format.html { redirect_to @deliver.person, warning: 'Amount was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
  def deliver_params
    params.require(:deliver).permit(:delivery, :fee, :discount, :delivery_date)
  end
end
