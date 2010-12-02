xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Clifton Studios"
    xml.description "Clifton Studios :: Winnipeg Manitoba based Artist Co-op"
    xml.link "http://cliftonstudios.ca"

    for item in @items
      if item.is_a?(Post)
        xml.item do
          xml.title item.title
          xml.description simple_format(item.body)
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://cliftonstudios.ca/news/#{item.permalink}"
        end
      elsif item.is_a?(Event)
        xml.item do
          xml.title item.title
          xml.description simple_format(item.starts_at.to_s(:with_time) + "\n\n" + item.description)
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://cliftonstudios.ca/events/#{item.permalink}"
        end
      end
    end
  end
end
