module JavascriptHelper

  def obfuscated_mail_to(email, label=nil)
    obfuscated = email.scan(/.{1,10}/).join("[REMOVE_THIS]")
    mail_to(email, label, :encode => "javascript") + "<noscript>#{mail_to(obfuscated, label || email.sub(/\@.*/, ""))}</noscript>".html_safe
  end

  def print_on_page_load
    content_for :js do
      javascript_include_tag 'print_on_page_load'
    end
  end

end
