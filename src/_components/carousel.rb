class Carousel < Bridgetown::Component
  def initialize(carousels:, number:, duration: nil)
    index = number.to_i - 1
    selected = Array(carousels)[index]

    @images =
      if selected.respond_to?(:images)
      Array(selected.images)
      elsif selected.is_a?(Hash)
        Array(selected["images"] || selected[:images])
      else
      []
      end

    @duration = duration&.to_i
  end

  def template
    return "" if @images.empty?

    autoplay_attrs =
      if @duration && @duration > 0
        %(autoplay autoplay-interval="#{@duration * 1000}")
      else
        ""
      end

    items_html = @images.each_with_index.map do |item, i|
    %(<wa-carousel-item><img src="#{item}" alt="Carousel image #{i + 1}"></wa-carousel-item>)
    end.join("\n")

    html -> { <<~HTML
    <section aria-label="Image carousel">
      <wa-carousel navigation pagination loop #{autoplay_attrs}>
        #{items_html}
      </wa-carousel>
    </section>
    HTML
    }
  end
end