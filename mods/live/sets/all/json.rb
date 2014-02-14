# -*- encoding : utf-8 -*-
format :json do

  view :export do |args|
    h = { :name    => card.name }
    code = card.codename and h[:code] = code
    h[:type] = card.type_name
    h.merge! _render_statu
    updater = card.updater and h[:updater] = updater.name
    h[:status] == :real and h[:creator] = card.creator.name
    h[:content] = card.raw_content
    h[:value] = _render_core args if @depth < max_depth
    h
  end

end
