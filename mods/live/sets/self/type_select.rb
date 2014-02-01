
format :html do
  view :core do |args|
    %{ <script type="text/template" class="live-type-selection">
      <span class="live-type-selection">#{
        type_field args.merge( :no_current_card=>true, :class=>'type-field live-type-field' )
      }</span>
    </script>}
  end
  view :raw, :core
end
