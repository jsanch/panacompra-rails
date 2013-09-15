# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :compra do
    sequence(:acto) { |n| "2013-09-03-CM#{n}" }
    sequence(:url) { |n| "http://www.panamacompra.gob.pa/compras/blah/#{n}" }
    sequence(:fecha) { Time.at(1.year.ago.to_f, Time.now.to_f) }
    entidad { Forgery(:name).company_name }
    proponente { Forgery(:name).company_name }
    description { Forgery(:lorem_ipsum).words(30) }
    precio { Forgery(:monetary).money }
    category
  end
end
