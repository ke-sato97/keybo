# frozen_string_literal: true

module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                  'キー坊(管理画面)'
                 else
                   'キー坊'
                 end

    page_title.empty? ? base_title : page_title
  end
end
