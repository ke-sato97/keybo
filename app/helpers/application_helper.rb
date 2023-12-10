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
    options[:class] += " transition-colors duration-300 rounded py-2 px-4 hover:bg-slate-500 text-slate-700 hover:text-white"

    if current_page?(path)
      options[:class] += " bg-slate-500 text-white"
    else
      options[:class] += " bg-transparent hover:bg-slate-500 text-slate-700 hover:text-white"
    end

    button_to(text, path, options)
  end
end
