class Willamette::HeaderNavbar < Bridgetown::Component
  def template
    html -> { <<~HTML
      #{html -> { dsd_style }}

      <div id="bar">
        <figure>
          <slot name="logo"></slot>
        </figure>

        <slot name="search"></slot>

        <nav>
          <slot name="nav"></slot>
        </nav>
        <slot name="theme_toggle"></slot>
      </div>
    HTML
    }
  end
end
