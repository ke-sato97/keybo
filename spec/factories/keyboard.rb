FactoryBot.define do
  factory :keyboard do
    name { 'name' }
    brand { 'brand' }
    price { '5000' }
    layout { 'layout' }
    size { 'size' }
    switch { 'switch' }
    url { 'url' }
    os { ['os1', 'os2'] }
    caption { 'caption' }
    connect { ['connect1', 'connect2'] }
  end
end
