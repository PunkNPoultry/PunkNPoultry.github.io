module Shared
  class Navbar < Bridgetown::Component
    attr_reader :metadata, :resource, :strategy

    # @param metadata [HashWithDotAccess::Hash]
    # @param resource [Bridgetown::Resource::Base]
    def initialize(metadata:, resource:)
      @metadata, @resource = metadata, resource

      @strategy = Willamette.navbar(
        self,
        logo: "/images/PnP_logo_bw.png",
        logo_alt: "Punk N Poultry - God Save The Farm",
        search: true,
        site_title: metadata.title,
        nav_links: [
          Willamette.link(title: t("nav.blog"), url: "/blog"),
          Willamette.link(title: t("nav.about"), url: "/about"),
          # Willamette.link(icon: "mastodon", icon_family: "brands", icon_label: "Mastodon", title: nil, url: "https://mastodon.social"),
        ]
      )
    end
  end

  class Sidebar < Bridgetown::Component
    attr_reader :metadata, :resource, :strategy

    # @param metadata [HashWithDotAccess::Hash]
    # @param resource [Bridgetown::Resource::Base]
    def initialize(metadata:, resource:)
      @metadata, @resource = metadata, resource

      explore_links = if resource.is_a?(Bridgetown::Resource::Base) && resource.collection.label == "docs"
                        Willamette.links_for(resource)
                      end

      @strategy = Willamette.sidebar(
        self,
        description: metadata.description,
        explore_links:,
        follow_links: [
          Willamette.link(icon: "rss", title: "Newsfeed", url: "/feed.xml"),
          # Willamette.link(icon: "bluesky", icon_family: "brands", title: "@myblue", url: "https://bsky.social"),
          Willamette.link(icon: "instagram", icon_family: "brands", title: "@punknpoultryfarm", url: "https://www.instagram.com/punknpoultryfarm/"),
          Willamette.link(icon: "github", icon_family: "brands", title: "punknpoultry", url: "https://github.com/punknpoultry"),
          Willamette.link(icon: "youtube", icon_family: "brands", title: "@punknpoultryfarm", url: "https://www.youtube.com/@punknpoultryfarm"),
          Willamette.link(icon: "tiktok", icon_family: "brands", title: "@tracy_punknpoultry", url: "https://www.tiktok.com/@tracy_punknpoultry")
        ],
        subscribe: false,
        see_also_links: [
          Willamette.link(icon: "soap", title: "Bark Soap Co.", url: "https://www.barksoap.com")
        ]
      )
    end
  end
end
