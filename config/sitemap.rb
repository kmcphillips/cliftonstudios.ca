# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.cliftonstudios.ca"

SitemapGenerator::Sitemap.create do
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host

  ## News posts
  Post.sorted.each do |post|
    add post_path(post), :lastmod => post.updated_at
  end

  # TODO: events. past?

  # TODO: pictures

  add artists_path

  Member.alphabetical.active.each do |member|
    add artist_path(member), :lastmod => member.updated_at
  end

  add "/about", :lastmod => Block.find_by_label("about").updated_at
  add "/links", :lastmod => Link.order("updated_at DESC").first.try(:updated_at)
  add "/login"

end
