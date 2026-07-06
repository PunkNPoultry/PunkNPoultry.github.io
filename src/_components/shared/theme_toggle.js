const storageKey = "pnp-theme"
const themeIcons = {
  system: "circle-half-stroke",
  light: "sun",
  dark: "moon"
}

const themeOrder = prefersDark => (prefersDark ? ["system", "light", "dark"] : ["system", "dark", "light"])

const getStoredTheme = () => {
  try {
    return localStorage.getItem(storageKey) || "system"
  } catch {
    return "system"
  }
}

const setStoredTheme = theme => {
  try {
    localStorage.setItem(storageKey, theme)
  } catch {
    // Ignore storage failures and keep the current session working.
  }
}

const applyTheme = theme => {
  const media = window.matchMedia("(prefers-color-scheme: dark)")
  const useDark = theme === "dark" || (theme === "system" && media.matches)

  document.documentElement.classList.toggle("wa-dark", useDark)
  document.documentElement.dataset.theme = theme
}

class ThemeToggle extends HTMLElement {
  connectedCallback() {
    this.button = this.querySelector("[data-theme-toggle-button]")
    this.icon = this.querySelector("[data-theme-toggle-icon]")

    if (!this.button || !this.icon) return

    this.media = window.matchMedia("(prefers-color-scheme: dark)")
    this.onClick = () => this.cycleTheme()
    this.onSystemChange = () => {
      if (getStoredTheme() === "system") {
        applyTheme("system")
        this.updateButton("system")
      }
    }

    this.button.addEventListener("click", this.onClick)
    this.media.addEventListener("change", this.onSystemChange)

    // Respect the theme's initial state already set by _head.erb, fall back to localStorage
    const theme = document.documentElement.dataset.theme || getStoredTheme()
    
    // Defer application to run after Willamette.init() completes
    // This ensures theme_toggle's choice wins over Willamette's system-preference-based application
    setTimeout(() => {
      applyTheme(theme)
    }, 0)
    
    this.updateButton(theme)
    // Only store if we're reading from default, to preserve explicit user choices
    if (!document.documentElement.dataset.theme) {
      setStoredTheme(theme)
    }
  }

  disconnectedCallback() {
    this.button?.removeEventListener("click", this.onClick)
    this.media?.removeEventListener("change", this.onSystemChange)
  }

  cycleTheme() {
    const theme = getStoredTheme()
    const order = themeOrder(this.media.matches)
    const nextTheme = order[(order.indexOf(theme) + 1) % order.length]

    setStoredTheme(nextTheme)
    applyTheme(nextTheme)
    this.updateButton(nextTheme)
  }

  updateButton(theme) {
    const label = `Theme: ${theme}`

    this.button.setAttribute("aria-label", label)
    this.button.setAttribute("title", label)
    this.icon.setAttribute("name", themeIcons[theme])
    this.dataset.theme = theme
    this.button.dataset.theme = theme
  }
}

if (!customElements.get("theme-toggle")) {
  customElements.define("theme-toggle", ThemeToggle)
}