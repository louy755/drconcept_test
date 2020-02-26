class InvoicePdf < Prawn::Document
    def initialize(person, view_context)
      super(top_margin: 20)
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
      @person = person
      @view_context = view_context
      info_tab
    end
    def price(num)
      @view_context.number_to_currency(num)
    end

    def invoice_number
      text "Invoice \##{@person.phone}", size: 10
    end
    def customer_name
      text "Customer name: #{@person.name.titleize}", size: 9
    end
    def info_tab
      text_box "#{invoice_number}", :kerning => true, :at => [0, y - 40]
      text_box "#{customer_name}", :kerning => true, :at => [380, y - 40]
      image "#{Rails.root}/public/pdf/set1.png", :width => 130, :height => 90, :position => :center
      move_down 10
      address_info
      person_info
      line_items

      move_down 5
      table [["#{price(sub_totls)} Sub total"],
           ["#{price(tax_calc)} TAX"],
           ["#{price(inv_delivery)} Delivery"],
           ["#{price(inv_fee)} Fee if Apply -"],
           ["#{price(inv_dicount)} Discount If apply"],
           [{:content =>"#{price(totall)} Total Due",:text_color => "ff3300"}],
           if @person.finance == true
            [{:content => "#{price(totall)}  ACEMA  Finance ",:colspan => 5,:size => 13, :text_color => "006400" }]
           else
            [{:content => "#{price(tot_pay)}  Payment Recived
              #{price(totall - tot_pay)} Remaining
              ",:colspan => 5,:size => 13, :text_color => "ff3300" }]
           end
          ], :position => :right, :column_widths => [190], :cell_style => {:background_color => "FFFFCC"}
    move_down 10
    text "Read over before signing, All deposits are non refundable. 90 days layaway only . ONE PAYMENT EVERY 30 DAY  IS REQUIRED  TO KEEP THE LAYAWAY ACTIVE LAYAWAY WITH NO ACTIVETY FOR 3 MONTHS WILL BE CANCELED .ALL SALES ARE FINAL. All merchandise is sold AS IS INSPECTED By the customer, without warranty, either expressed or implied, except may be offered by the original manufacturer and not the seller. All SALES ARE FINAL and NOT subject to customer cancellation, return. Allowance, charge back, credit adjustments, service or exchange.cus Failure to pick up or accept delivered merchandise may result in20% RESTOCKING FEE OF THE PURCHASE PRICE. Received Merchandise in Good Condition", size: 9
    move_down 25
    text "Customer Signature:  --------------------------------------------------------", size: 10
    move_down 25
    text "Thank You!", size: 11, :align => :center
    end
    def address_info
      text "7601 South Cicero Ave  unit 1486 Chicago il 60652    Phone 773-735-8800 Fax 773-735-8806 \n
      DELIVERY INFORMATION  CALL  773-735-8800", size: 7, style: :bold, :align => :center
    end

    def person_info
      move_down 10
      table line_info_rows do
        row(0).font_style = :bold
        columns(0).width = 90
        columns(2).width = 160
        row(0).style :background_color => '3CB371'
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_info_rows
      [["Name", "Phone", "Adress", 'Adress2', "city", "State", "Zip"]] +
      [[@person.name.titleize, @person.phone, @person.address.titleize, @person.address2, @person.city.titleize, @person.state, @person.zip]]
    end
    def line_items
      move_down 10
      table line_item_rows do
        row(0).font_style = :bold
        row(0).style :background_color => 'ccf2ff'
        columns(1).width = 110
        columns(2).width = 110
        columns(3).width = 55
        columns(4).width = 70
        columns(5).width = 150
        self.row_colors = [ "FFFFFF", "DDDDDD"]
        self.header = true
      end
    end
    def line_item_rows
      [["QNT", "Item", "Description", "Price", "Subtotal", "Date" ]] +
      @person.goods.map do |itm|
        [itm.qnt,itm.item, itm.description, price(itm.price), "#{sub_totls }", itm.created_at.strftime("%A, %d %b %Y") ]
      end
    end
  end
