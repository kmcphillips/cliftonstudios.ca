class DefaultFormBuilder < ActionView::Helpers::FormBuilder 

  def error_messages
    @template.render :partial => "/shared/error_messages", :object => self.object
  end

  def item(type, name, opts={})
    note = opts.delete :note

    @template.content_tag(:li) do
      if type.to_sym == :submit
        @template.content_tag(:label, "&nbsp;".html_safe) + 
        self.send(type, name)
      else
        self.label(name, opts.delete(:label)) + 
        self.send(type, name, opts) +
        (note.blank? ? "" : @template.content_tag(:span, note, :class => "note"))
      end
    end
  end

end

