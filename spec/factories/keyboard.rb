FactoryBot.define do
  factory :keyboard do
    name { 'ロジクール ワイヤレスキーボード K295GP K295OW 静音 耐水 キーボード 無線 Unifying windows chrome K295  ' }
    brand { 'logicool' }
    price { 3800 }
    layout { 'JIS配列' }
    size { 'フルサイズ' }
    switch { 'メンブレン' }
    url { 'https://hb.afl.rakuten.co.jp/hgc/g00tpxde.y5ugef4d.g00tpxde.y5ugfcdb/?pc=https%3A%2F%2Fitem.rakuten.co.jp%2Flogicool%2Fk295gp%2F&m=http%3A%2F%2Fm.rakuten.co.jp%2Flogicool%2Fi%2F10000345%2F' }
    os { ['windows', 'mac'] }
    caption { 'caption' }
    connect { ['bluetooth', '有線'] }
    medium_image_urls { ["https://thumbnail.image.rakuten.co.jp/@0_mall/logicool/cabinet/prd/kb/k295gp/k295gp_01_r-1.jpg?_ex=128x128",
                          "https://thumbnail.image.rakuten.co.jp/@0_mall/logicool/cabinet/prd/kb/k295gp/k295gp_02.jpg?_ex=128x128",
                          "https://thumbnail.image.rakuten.co.jp/@0_mall/logicool/cabinet/prd/kb/k295gp/k295gp_03.jpg?_ex=128x128"]
                         }
  end
end
