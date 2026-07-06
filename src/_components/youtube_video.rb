class YoutubeVideo < Bridgetown::Component
  def initialize(id:, height: 360, width: 640)
    @id, @height, @width = id, height, width
  end

  def template
    html -> { <<~HTML
      <section aria-label="YouTube video" class="inline-bleed">
        <iframe
            title="YouTube video player"
            width="#{@width}"
            height="#{@height}"
            src="https://www.youtube.com/embed/#{@id}"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            allowfullscreen>
        </iframe>
      </section>
    HTML
    }    
  end
end
