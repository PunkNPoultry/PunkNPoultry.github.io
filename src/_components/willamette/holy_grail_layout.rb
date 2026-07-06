class Willamette::HolyGrailLayout < Bridgetown::Component
  def template
    # inspired by Una Kravets demo: https://codepen.io/una/pen/mdVbdBy

    html -> { <<~HTML
      #{html -> { dsd_style }}

      <slot name="skip-to-content"></slot>
      <slot name="header" part="header"></slot>
      <slot name="sidebar-start" part="sidebar-start"></slot>
      <slot name="content" part="content"></slot>
      <slot name="sidebar-end" part="sidebar-end"></slot>
      <slot name="footer" part="footer"></slot>
    HTML
    }
  end
end
