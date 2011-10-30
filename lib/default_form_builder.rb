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

  def member_since
    raise "member_since can only be called on members" unless self.object.is_a?(Member)

    @template.content_tag(:li) do
      @template.content_tag(:label, "Member Since") +
      select(:member_since_month, @template.options_for_select(Date::MONTHNAMES.map{|m| m ? [m,m] : ["Month...", nil]}, :selected => object.member_since_month)) +
      select(:member_since_year, @template.options_for_select([["Year...", nil]] + ((Date.today.year - 32)..Date.today.year).to_a.reverse.map{|y| [y,y]}, :selected => object.member_since_year))
    end
  end

end

