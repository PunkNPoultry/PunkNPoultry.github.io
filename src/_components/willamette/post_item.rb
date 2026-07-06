class Willamette::PostItem < Bridgetown::Component
  using Bridgetown::Refinements

  def self.styles = [
    :headline_only,
    :headline_with_summary,
    :headline_with_image,
    :headline_with_image_and_summary,
  ].freeze

  def initialize(post:, post_style: :headline_only, heading_level: 2)
    post_style = post_style.to_sym
    unless post_style.within?(self.class.styles)
      raise "Post style must be one of these options: #{self.class.styles.join(", ")}"
    end

    @post = post
    @post_style = post_style
    @heading_level = heading_level
  end

  def template = send(@post_style)

  def headline_only
    # TODO: what about title with html tags?
    html -> { <<~HTML
      <wll-post-item #{text->{__callee__.to_s.dasherize}}>
        <strong>#{html->{@post.data.title}}</strong>
        #{html->{timestamp}}
      </wll-post-item>
    HTML
    }
  end

  def headline_with_summary
    html -> { <<~HTML
      <wll-post-item #{text->{__callee__.to_s.dasherize}}>
        <hgroup>
          #{html->{heading @post.data.title}}
          <p>#{html->{summary}}</p>
        </hgroup>
        #{html->{timestamp}}
      </wll-post-item>
    HTML
    }
  end

  def headline_with_image(show_summary: false) # rubocop:disable Metrics
    image_path = @post.data.image.is_a?(String) ? @post.data.image : @post.data.image&.path
    image_alt =
      @post.data.image.is_a?(String) ?
        t("content.featured_post_image") :
        (@post.data.image&.alt || @post.data.image&.caption)
    # image_path ||= default_image_data
    return headline_with_summary if image_path.nil?
    html -> { <<~HTML
      <wll-post-item #{text->{__callee__.to_s.dasherize}}>
        <hgroup>
          <figure><img src="#{text->{image_path}}" alt="#{text->{image_alt}}" /></figure>
          #{html->{heading @post.data.title}}
          #{html(->{ show_summary ? <<~HTML
            <p>#{html->{summary}}</p>
          HTML
          : "" })}
        </hgroup>
        #{html->{timestamp}}
      </wll-post-item>
    HTML
    }
  end

  def headline_with_image_and_summary = headline_with_image(show_summary: true)

  private

  def default_image_data
    <<~URL.strip
      data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20640%20640%22%3E%3Cpath%20d%3D%22M160%20144C151.2%20144%20144%20151.2%20144%20160L144%20480C144%20488.8%20151.2%20496%20160%20496L480%20496C488.8%20496%20496%20488.8%20496%20480L496%20160C496%20151.2%20488.8%20144%20480%20144L160%20144zM96%20160C96%20124.7%20124.7%2096%20160%2096L480%2096C515.3%2096%20544%20124.7%20544%20160L544%20480C544%20515.3%20515.3%20544%20480%20544L160%20544C124.7%20544%2096%20515.3%2096%20480L96%20160zM224%20192C241.7%20192%20256%20206.3%20256%20224C256%20241.7%20241.7%20256%20224%20256C206.3%20256%20192%20241.7%20192%20224C192%20206.3%20206.3%20192%20224%20192zM360%20264C368.5%20264%20376.4%20268.5%20380.7%20275.8L460.7%20411.8C465.1%20419.2%20465.1%20428.4%20460.8%20435.9C456.5%20443.4%20448.6%20448%20440%20448L200%20448C191.1%20448%20182.8%20443%20178.7%20435.1C174.6%20427.2%20175.2%20417.6%20180.3%20410.3L236.3%20330.3C240.8%20323.9%20248.1%20320.1%20256%20320.1C263.9%20320.1%20271.2%20323.9%20275.7%20330.3L292.9%20354.9L339.4%20275.9C343.7%20268.6%20351.6%20264.1%20360.1%20264.1z%22%2F%3E%3C%2Fsvg%3E
    URL
  end

  def heading(contents)
    "<h#{@heading_level}>#{text contents, ->{ strip_html | smartify }}</h#{@heading_level}>"
  end

  def summary = @post.data.subtitle || @post.data.description || strip_html(@post.summary)

  def timestamp(date = @post.data.date)
    "<time>#{text date.to_date, -> { l format: :short }}</time>"
  end
end
