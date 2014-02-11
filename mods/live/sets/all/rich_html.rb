
format :html do
  view :live_titled, :tags=>:comment do |args|
    wrap args do
      %{
        #{ _render_header args.merge :show_menu=>false, :show=>"type #{args[:show]}" }
        #{ wrap_body( :content=>true ) { _render_core args } }
        #{ optional_render :comment_box, args }
      }
    end
  end

  view :header do |args|
    %{
      <h1 class="card-header">
      </h1>
    }
  end
  view :header do |args|
    %{
      <h1 class="card-header">
        #{ _optional_render :toggle, args, :hide }
        #{ _optional_render :title, args }
        #{ _optional_render :menu, args }
        #{ _optional_render :type, args, default_hidden=true }
      </h1>
    }
  end
end
