module ApplicationHelper

  def page_title
    title = "Clifton Studios"
    title << " :: Members Area" if members_area?
    
    if @title
      @title.blank? ? title : "#{title} :: #{@title}"
    elsif params[:controller] =~ /blocks$/
      "#{title} :: #{params[:action].humanize}"
    else
      title
    end
  end

  def index_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/index.png", :alt => "Index"), path, :title => "Index", :class => "action-image"
    html += "&nbsp;".html_safe + link_to(label, path) if label
    html
  end

  def new_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/new.png", :alt => "New"), path, :title => "New", :class => "action-image"
    html += "&nbsp;".html_safe + link_to(label, path) if label
    html
  end

  def destroy_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/delete.png", :alt => "Delete"), path, :method => :delete, :confirm => "Are you sure you want to delete this?", :title => "Delete", :class => "action-image"
    html += "&nbsp;".html_safe + link_to(label, path, :method => :delete, :confirm => "Are you sure you want to delete this?") if label
    html
  end

  def edit_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/edit.png", :alt => "Edit"), path, :title => "Edit", :class => "action-image"
    html += "&nbsp;".html_safe + link_to(label, path) if label
    html
  end

  def show_entity_image(path, label=nil, args={})
    path = polymorphic_path(path) if path.is_a?(Array)
    html = link_to image_tag("/images/icons/show.png", :alt => "Show"), path, :title => "Show", :class => "action-image"
    html += "&nbsp;".html_safe + link_to(label, path) if label
    html
  end

  def enlarge_button
    "Enlarge&nbsp;" + image_tag("/images/icons/magnify.png", :alt => "Enlarge", :class => :magnify)
  end

  def boolean_image(value)
    image_tag("/images/icons/#{!!value}.png", :alt => (!!value).to_s.humanize)
  end

  def obfuscated_mail_to(email, label=nil)
    obfuscated = email.scan(/.{1,10}/).join("[REMOVE_THIS]")
    mail_to(email, label, :encode => "javascript") + "<noscript>#{mail_to(obfuscated, label || email.sub(/\@.*/, ""))}</noscript>".html_safe
  end

  def collection_index(collection, column_titles, options={}, &block)
    content_tag(:table, :class => (options[:class] || "data"), :id => options[:id]) do
      content_tag(:tbody) do
        src = ""

        src << content_tag(:tr) do
          headers = ""
          column_titles.each do |title|
            headers << content_tag(:th, title)
          end
          headers.html_safe
        end

        collection.each do |item|
          src << content_tag(:tr) do
            yield(item)
          end
        end

        if collection.paginate?
          src << content_tag(:tr) do
            content_tag(:th, :colspan => column_titles.size) do
              will_paginate(collection, :previous_label => "← Newer", :next_label => "Older →")
            end
          end
        end

        src.html_safe
      end
    end
  end

  def pagination_params(opts={})
    {:page => params[:page] || 1, :per_page => (members_area? ? PAGINATION_PER_TABLE : PAGINATION_PER_PAGE)}.merge(opts)
  end

  def will_paginate_with_opts(collection)
    will_paginate(collection, :previous_label => "← Newer", :next_label => "Older →")
  end

  def truncate_for_index(str)
    truncate(str, :length => 120, :omission => " (more..)")
  end

  def row_class
    cycle("odd", "even")
  end

  def members_area?
    !!(params[:controller] =~ /^members\//)
  end

  def nav_underline
    index = case params[:controller]
      when "posts" then 0
      when "events" then 1
      when "artists" then 2
      when "pictures" then 3
      when "blocks"
        if params[:action] == "about"
          4
        elsif params[:action] == "links"
          5
        end
    end

    content_tag(:div, nil, :id => :navunder, :style => index ? "margin-left: #{66 + (index * 110)}px" : "background: transparent")
  end

  def social_media_icon(type, path, options={})
    alt = options[:alt] || "Follow us on #{type.to_s.humanize}"

    link_to image_tag("/images/icons/social/#{type}-32.png", :alt => alt, :class => options[:class]), path, :title => alt
  end



  ## Overridden paths

  def post_path(post)
    "/news/#{post.permalink}"
  end

  def posts_path
    "/"
  end

end
