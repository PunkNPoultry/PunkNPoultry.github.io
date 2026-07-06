class Figure < Bridgetown::Component
  def initialize(src:, alt: nil, caption: nil, height: nil, width: nil)
    @src, @alt, @caption, @height, @width = src, alt, caption, height, width
  end

  def template
    html -> { <<~HTML
      <figure class="pnp-figure">
        <img loading="lazy" src="#{@src}" alt="#{@alt || @caption}" #{%(height="#{@height}") if @height} #{%(width="#{@width}") if @width}>
        #{'<figcaption><wa-tag appearance="outlined">' + @caption + '</wa-tag></figcaption>' if @caption}
      </figure>
    HTML
    }    
  end
end
