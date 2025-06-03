# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Property.create!({
    name: 'Sample ',
    description: 'a32d',
    headline: 'gt44y',
    address_1: 'tgtr',
    address_2: 'fvfev',
    city: 'rrrt',
    state: 'rrrr',
    country: 'hrrrrt',
})
 
Property.create!({
    name: 'Sample Property',
    description: 'as',
    headline: 'g',
    address_1: 't',
    address_2: 'r',
    city: 't',
    state: 't',
    country: 't',
})
 

