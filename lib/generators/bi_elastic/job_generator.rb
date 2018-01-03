require 'rails/generators/base'
module BiElastic
  module Generators
    class JobGenerator < Rails::Generators::Base
      desc 'this places a job for bi-client'
      def create_initializer_file
        create_file 'app/jobs/bi_elastic_client_job.rb', job_file_content
      end

      private

      def job_file_content
        cnt = <<-EOF
class BiElasticClientJob < ActiveJob::Base
  queue_as :default

  # type is either 'order' or 'uniq'
  def perform(type, hash)
    raise "wrong type" unless %w{ order uniq }.include?( type )

    ret = case type
          when 'order'
            BiElastic::Client.new.report_order(hash)
          when 'uniq'
            BiElastic::Client.new.report_uniq(hash)
          end

    raise "BiElastic::Client - report failed" unless ret == true
    true
  end
end
EOF
        cnt
      end
    end
  end
end
