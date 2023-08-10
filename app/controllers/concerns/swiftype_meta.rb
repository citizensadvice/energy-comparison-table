# frozen_string_literal: true

# Adds swiftype meta tags to make the rendered pages indexable by our internal search enging

module SwiftypeMeta
  extend ActiveSupport::Concern

  included do
    helper_method :swiftype_meta

    def swiftype_meta
      @swiftype_meta ||= []
    end

    private

    def add_swiftype_meta(meta_tags)
      swiftype_meta.concat(meta_tags)
    end
  end
end
