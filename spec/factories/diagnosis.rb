FactoryBot.define do
  factory :diagnosis do
    user
    keyboard

    factory :selected_keyboard do
      name { 'string' }
      brand { 'string' }
      price { 2000 }
      layout { 'JIS配列' }
      size { 'フルサイズ' }
      switch { 'メンブレン' }
      url { 'url' }
      os { %w[windows mac] }
      medium_image_urls { ['https://thumbnail.image.rakuten.co.jp/@0_mall/logicool/cabinet/prd/kb/k270/k270_01_r.jpg?_ex=128x128'] }
      caption { 'string' }
      connect { %w[bluetooth 有線] }
    end
  end
end
