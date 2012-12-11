class AddressDrop < Cms::BaseDrop
  
  liquid_attributes << :id << :firstname  << :lastname << :address1 << :address2 << :city << :country << :shipments << :state << :location << :zipcode << :phone << :alternative_phone << :secondname
  #liquid_attributes << :state << :zipcode << :phone << :state_name << :alternative_phone << :secondname

end