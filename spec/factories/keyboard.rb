FactoryBot.define do
  factory :keyboard do
    name { 'name' }
    brand { 'brand' }
    price { 2000 }
    layout { 'JIS配列' }
    size { 'フルサイズ' }
    switch { 'メンブレン' }
    url { 'url' }
    os { ['windows', 'mac'] }
    caption { 'caption' }
    connect { ['bluetooth', '有線'] }
  end
end
