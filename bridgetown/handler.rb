require 'aws-sdk-s3'
require 'aws-sdk-cloudfront'
require 'bridgetown'
require 'pathname'
require 'pry'

SITE_ROOT  = ENV['LAMBDA_TASK_ROOT']

$s3_client = Aws::S3::Client.new
$cdn_client = Aws::CloudFront::Client.new

# extracts data from the contentful event and generates
# generates a bridgetown data file
module EnergyTableComparison
  class Model
    def self.generate(contentful_event)
      # generate e.g./tmp/contentful.yaml for use by a bridgetown Builder later
    end
  end

  # generates the bridgetown site
  class SiteGenerator
    MIME_TYPES = {
      js: "text/javascript",
      css: "text/css",
      map: "application/json",
      html: "text/html",
      svg: "image/svg+xml"
    }.freeze

    # @return [Array]: the list of site files
    def self.generate
      config = Bridgetown.configuration({
                                          # the only writable path
                                          'destination' => '/tmp/dist',
                                          'root_dir' => SITE_ROOT,
                                          'source' => "#{SITE_ROOT}/src",
                                          'skip_config_files' => true,
                                          'disable_disk_cache' => true
                                        })
      site = Bridgetown::Site.new(config)
      site.generate

      # need to return list of all generated files
      # e.g ["index.html", "css/stylesheet.css",......]
      # but for now we mock it:

      static_files = Dir.glob("./energy_tables/output/**/*").map do |path|
        content_type = infer_content_type(path)

        next if content_type.nil?
        pathname = Pathname.new(File.expand_path(path))

        {
          filename: pathname.basename.to_path,
          file_path: pathname.to_path,
          content_type: infer_content_type(path),
        }
      end
      
      static_files.compact
    end

    def self.infer_content_type(filename)
      ext = filename.split(".").last
      MIME_TYPES[ext.to_sym]
    end
  end
end

def handler(event:, context:)
  bucket_name = ENV['BUCKET_NAME']
  distribution_id = ENV['DISTRIBUTION_ID']

  ::EnergyTableComparison::Model.generate(event)
  contents = ::EnergyTableComparison::SiteGenerator.generate

  # AWS SDKs don't support recursive copy / sync
  contents.each do |file|
    $s3_client.put_object(body: File.new(file[:file_path]).read, bucket: bucket_name, key: file[:filename], content_type: file[:content_type])
  end
  $cdn_client.create_invalidation(distribution_id: distribution_id,
                                  invalidation_batch: {
                                    paths: {
                                      quantity: 1,
                                      items: ['/*']
                                    },
                                    caller_reference: "Energy Supplier Comparison Table site builder #{Time.now}"
                                  })
end
