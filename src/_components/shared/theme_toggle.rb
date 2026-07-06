module Shared
  class ThemeToggle < Bridgetown::Component
    def template
      html -> { <<~HTML
      <theme-toggle class="theme-toggle" slot="theme_toggle">
        <wa-button type="button"  appearance="plain" class="theme-toggle__button" data-theme-toggle-button aria-label="Theme: system" title="Theme: system">
          <wa-icon family="solid" name="circle-half-stroke" data-theme-toggle-icon></wa-icon>
        </wa-button>
      </theme-toggle>
      HTML
      }
    end
  end
end