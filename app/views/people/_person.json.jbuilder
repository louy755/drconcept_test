json.extract! person, :id, :name, :phone, :email, :address, :address2, :city, :state, :zip, :full_payment, :subtotal, :tax, :total, :user_id, :created_at, :updated_at
json.url person_url(person, format: :json)
