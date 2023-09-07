# frozen_string_literal: true

module Renderers
  class RichTextRenderer < RichTextRenderer::Renderer
    def render_with_breaks(node)
      return if node.blank?

      # We can trust content from Contentful
      # rubocop:disable Rails/OutputSafety
      render(node.json).gsub("\n", "<br/>").html_safe
      # rubocop:enable Rails/OutputSafety
    end
  end
end
