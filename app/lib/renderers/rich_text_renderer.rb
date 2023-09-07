# frozen_string_literal: true

module Renderers
  class RichTextRenderer < RichTextRenderer::Renderer
    def render_with_breaks(node)
      render(node.json).gsub("\n", "<br/>").html_safe
    end
  end
end
