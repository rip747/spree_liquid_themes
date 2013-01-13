class OptionValueDrop < Liquid::Core::BaseDrop
  liquid_attributes << :name << :option_type << :position << :presentation << :variants
end