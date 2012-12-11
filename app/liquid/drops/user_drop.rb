class UserDrop < Cms::BaseDrop
  
  liquid_attributes << :email << :login << :ship_address << :bill_address << :orders << :roles
  
end