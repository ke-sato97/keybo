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

  def nav_button(text, path, options = {})
    options[:class] ||= ""
    options[:class] += " transition-colors duration-500"

    if current_page?(path)
      options[:class] += " text-slate-700 text-slate-700 border-b-2 py-2 px-3 border-slate-500"
    else
      options[:class] += " rounded py-2 px-3 bg-transparent hover:bg-slate-500 text-slate-700 hover:text-white"
    end

    # button_toメソッドの呼び出し
    button_to(text, path, options)
  end
end
