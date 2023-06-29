require 'aws-sdk-s3'
require 'aws-sdk-cloudfront'
require 'bridgetown'
require 'pathname'

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

      index = '/tmp/index.html'
      IO.write(index, <<~EOF
        <!DOCTYPE html>
        <html>
        <body>

        <h1>Ha!</h1>
        la la la
        <p>42</p>

        </body>
        </html>
      EOF
      )
      [index]
    end
  end
end

def handler(event:, context:)
  bucket_name = ENV['BUCKET_NAME']
  distribution_id = ENV['DISTRIBUTION_ID']

  ::EnergyTableComparison::Model.generate(event)
  contents = ::EnergyTableComparison::SiteGenerator.generate

  # AWS SDKs don't support recursive copy / sync
  contents.each do |filename|
    file_path = Pathname.new(File.expand_path(filename))
    obj_key = file_path.basename
    $s3_client.put_object(body: file_path.read, bucket: bucket_name, key: obj_key.to_path, content_type: 'text/html')
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
