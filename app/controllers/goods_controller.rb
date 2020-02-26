class GoodsController < ApplicationController
  def index
    @goods = Good.all
  end

  def show
    @good = Good.find(params[:id])
  end

  def create
    @person = Person.find(params[:person_id])
    @good = @person.goods.build(good_params)
    @good.save
    respond_to do |format|
      format.html { redirect_to @person, success: 'Item was Added to your Recipt successfuly!.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @good.destroy
    respond_to do |format|
      format.html { redirect_to @good.person, warning: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def good_params
    params.require(:good).permit(:qnt, :price, :subtotal, :tax, :vendor, :item, :cost, :description)
  end
end
