class Spree::AddressDrop < Clot::BaseDrop

  class_attribute :liquid_attributes
  self.liquid_attributes =  [:id, :firstname, :lastname, :address1, :address2, :city, :country, :shipments, :state, :location, :zipcode, :phone, :alternative_phone, :secondname]
end