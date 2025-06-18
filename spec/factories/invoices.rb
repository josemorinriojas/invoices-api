FactoryBot.define do
  factory :invoice do
    invoice_date { Time.zone.today }
    total { 1000 }
    status { "Vigente" }
  end
end