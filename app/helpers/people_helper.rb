module PeopleHelper
  def sub_totls
    sub_totls = 0
    @person.goods.each do |comt|
      sub_totls += comt.qnt * comt.price
    end
    sub_totls
  end
  def tax_calc
    tax_calc = sub_totls * 10.25 / 100
  end
  def tot_pay
    tot_pay = 0
    @person.pays.each do |pay|
      tot_pay += pay.amount
    end
    tot_pay
  end
  def inv_dicount
    inv_dicount = 0
    @person.delivers.each do |delv|
      inv_dicount += delv.discount
    end
     inv_dicount ||= "00.00"
  end
  def inv_delivery
    inv_delivery = 0
    @person.delivers.each do |delv|
      inv_delivery += delv.delivery
    end
    inv_delivery ||= "00.00"
  end
  def inv_fee
      inv_fee = 0
    @person.delivers.each do |delv|
       inv_fee = delv.fee
    end
    inv_fee
  end
  def totall
    totll = tax_calc + sub_totls + inv_fee + inv_delivery - inv_dicount
  end
  def tot
    tot = 0
    tot = (totall - tot_pay).round(2)
  end
  def total_invoices
    totals = 0
    Person.all.each do |per|
     totals += per.total
    end
    totals
  end
  def total_subs
    total_subs = 0
    Person.all.each do |per|
     total_subs += per.subtotal
    end
    total_subs
  end
  def total_taxs
    total_taxs = 0
    Person.all.each do |per|
     total_taxs += per.tax
    end
    total_taxs
  end
  def total_costs
    total_costs = 0
    Person.all.each do |per|
     total_costs += per.cost
    end
    total_costs
  end
  def total_delvs
    total_delvs = 0
    Person.all.each do |per|
     total_delvs += per.delivery
    end
    total_delvs
  end
  def total_profits
    total_profits = 0
    Person.all.each do |per|
     total_profits += per.profit
    end
    total_profits
  end
end
