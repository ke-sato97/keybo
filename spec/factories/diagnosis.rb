FactoryBot.define do
  factory :diagnosis do
    association :user
    association :keyboard

    factory :selected_keyboard do
      name { 'name' }
      brand { 'brand' }
      price { 12000 }
      layout { 'JIS配列' }
      size { 'フルサイズ' }
      switch { 'メンブレン' }
      url { 'url' }
      os { ['windows', 'mac'] }
      caption { 'caption' }
      connect { ['bluetooth', '有線'] }
    end
  end
end
