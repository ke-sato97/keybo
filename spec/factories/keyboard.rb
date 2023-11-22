FactoryBot.define do
  factory :keyboard do
    name { 'name' }
    brand { 'brand' }
    price { '11111' }
    layout { 'layout' }
    size { 'size' }
    switch { 'switch' }
    url { 'url' }
    os { ['os1', 'os2'] }
    medium_image_urls { ['medium_image_urls1', 'medium_image_urls2' ] }
    caption { 'caption' }
    connect { ['connect1', 'connect2'] }
  end
end
