
format :html do
  view :live_titled, :tags=>:comment do |args|
    wrap :live_titled, args do
      %{
        #{ _render_header args.merge :hide_menu=>true, :show=>"type #{args[:show]}" }
        #{ wrap_body( :content=>true ) { _render_core args } }
        #{ optional_render :comment_box, args }
      }
    end
  end
end
