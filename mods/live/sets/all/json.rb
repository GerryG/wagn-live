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
    
    unless @depth == max_depth
      h[:value] = _render default_item_view, args
    end
    if @depth==0
      {
        :url => controller.request.original_url,
        :timestamp => Time.now.to_s,
        :card => h
      }
    else
      h
    end
  end

end
