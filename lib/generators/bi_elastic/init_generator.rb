require 'rails/generators/base'

module BiElastic
  module Generators
    class InitGenerator < Rails::Generators::Base
      desc 'this will create an initializer for BI::Client in config/initializer'
      def create_initializer_file
        create_file 'config/initializers/bi_elastic.rb', init_file_content
      end

      private

      def init_file_content
        cnt = <<-EOF
BiElastic.configure do |config|
  # config.disabled =  false                                  # default is false
  # config.reporter = 'schnet'
  # config.elastic_host = 'your.elastic-host.net'
  # config.elastic_user = 'elastic'
  # config.elastic_password = 'changeme'
end
EOF
        cnt
      end
    end
  end
end
