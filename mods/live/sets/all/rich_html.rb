
format :html do
  view :live_titled, :tags=>:comment do |args|
    wrap :live_titled, args do
      %{
        #{ _render_header args.merge(:menu_default_hidden=>true, :hidden_type=>true) }
        #{ wrap_body( :content=>true ) { _render_core args } }
        #{ optional_render :comment_box, args }
      }
    end
  end

  view :header do |args|
    %{
      <h1 class="card-header">
        #{ args.delete :toggler }
        #{ _render_title args }
        #{ _render_type args.merge( :type_class=>"type-hidden" ) if args[:hidden_type] }
        #{
          args[:custom_menu] or unless args[:hide_menu]                          # developer config
            _optional_render :menu, args, (args[:menu_default_hidden] || false)  # wagneer config
          end
        }
      </h1>
    }
  end
end
