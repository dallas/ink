ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag !~ /label/
    %(<div class="field_with_error">#{html_tag}</div>)
  else
    html_tag
  end
end
