# app/services/keyboard_search_service.rb
class KeyboardSearchService
  def initialize(keyword)
    @keyword = keyword
  end

  def perform
    return [] if @keyword.blank?

    results = RakutenWebService::Ichiba::Item.search(keyword: @keyword, hits: 5)

    results.map do |result|
      KeyboardUpdater.new(result).update_or_create
    end
  end
end
