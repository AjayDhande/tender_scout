class CountrySerializer < ActiveModel::Serializer
  attributes :id, :code, :number, :alpha2code, :alpha3code, :name, :world_region, :world_subregion, :other_names
end
