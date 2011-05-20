class DefaultFormBuilder < ActionView::Helpers::FormBuilder 

  def error_messages
    @template.render :partial => "/shared/error_messages", :object => self.object
  end

end
