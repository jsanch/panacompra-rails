# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

Category.create({id: 50, name: 'Alimentos, Bebidas y Tabaco'}, without_protection: true)
Category.create({id: 40, name: 'Sistemas, Equipos y Componentes de Distribución y Acondicionamiento'}, without_protection: true)
Category.create({id: 85, name: 'Servicios Sanitarios'}, without_protection: true)
Category.create({id: 15, name: 'Combustibles, Aditivos para combustibles, Lubricantes y Materiales Anticorrosivos'}, without_protection: true)
Category.create({id: 31, name: 'Componentes y Suministros de Fabricacion'}, without_protection: true)
Category.create({id: 30, name: 'Componentes y Suministros de Fabricacion, Estructuras, Obras y Construcciones'}, without_protection: true)


