# frozen_string_literal: true

module MetaTagsHelper
  # See https://github.com/kpumuk/meta-tags
  def default_meta_tags
    image_url = "http://www.citizensadvice.org.uk/Images/Public/socialmedia/Consumer.png"

    {
      charset: "UTF-8",
      site: "Citizens Advice",
      # By default meta-tags puts the site name _before_ the page name in the title.
      # We want the opposite. The `reverse` option flips this order.
      reverse: true,
      separator: "-",
      viewport: "width=device-width, initial-scale=1.0",
      og: {
        title: :title,
        description: :description,
        image: image_url,
        type: "article",
        url: format_canonical_url
      },
      twitter: {
        card: "summary_large_image",
        site: "@CitizensAdvice",
        image: image_url,
        title: :title,
        description: :description,
        url: format_canonical_url
      }
    }
  end

  def format_canonical_url
    path = request.path.split("?")[0]
    normalised_path = path.ends_with?("/") ? path : "#{path}/"

    "https://www.citizensadvice.org.uk#{normalised_path}"
  end
end
