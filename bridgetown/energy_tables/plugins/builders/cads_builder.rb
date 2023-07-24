# frozen_string_literal: true

require "bundler/setup"
require "view_component/engine"
require "citizens_advice_components"

module Builders
  class CadsBuilder < SiteBuilder
    def build 
      site.config.loaded_cads ||= begin
        cads_loader = Zeitwerk::Loader.new
        CitizensAdviceComponents::Engine.config.autoload_paths.each do |path|
          cads_loader.push_dir path
        end
        cads_loader.setup
        cads_loader.eager_load
        true
      end
    end
  end
end