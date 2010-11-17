atom_feed do |feed|
  feed.title(BLOGNAME)
  feed.updated((@posts.live.last.post_at))

  for post in @posts
    feed.entry(post) do |entry|
      entry.title(post.textilized_title)
      entry.content(post.textilized_body, :type => 'html')

      entry.author do |author|
        author.name(BLOGAUTHOR)
      end
    end
  end
end
