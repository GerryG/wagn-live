# -*- encoding : utf-8 -*-
format :json do

  view :export do |args|
    h = _render_atom.merge _render_statu
    if h[:status] == :real
      h[:creator] = card.creator.name
      h[:updater] = card.updater.name
      h[:updated_at] = card.updated_at.to_s
    end
    h
  end

end
