require 'json'
require 'elasticsearch'

# Business Intelligence client module
module BiElastic
  require 'bi_elastic/railtie' if defined?(Rails)

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Environment specific configuration options
  class Configuration
    attr_accessor :disabled
    attr_accessor :elastic_user
    attr_accessor :elastic_password
    attr_accessor :elastic_host
    attr_accessor :reporter

    def initialize
      @elastic_host = 'example.com'
      @elastic_user = 'elastic'
      @elastic_password = 'changeme'
      @reporter = 'x'
      @disabled = false
    end
  end

  class Client
    def initialize
      @host = BiElastic.configuration.elastic_host
      @user = BiElastic.configuration.elastic_user
      @password = BiElastic.configuration.elastic_password
      @reporter = BiElastic.configuration.reporter
      @disabled = BiElastic.configuration.disabled
    end

    def report_uniq(args)
      return true if @disabled
      args = add_reporter(args)
      check_uniq_args(args)
      res = connection.index index: 'uniques-index', type: 'uniq', body: args
      check_result(res)
    end

    def report_order(args)
      return true if @disabled
      args = add_reporter(args)
      check_order_args(args)
      res = connection.index index: 'orders-index', type: 'order', body: args
      check_result(res)
    end

    private

    def check_result(res)
      return true if res['result'] == 'created'
      puts res.inspect
    end

    def connection
      Elasticsearch::Client.new(
        host: @host,
        port: '9200',
        user: @user,
        password: @password,
        scheme: 'http'
      )
    end

    def check_order_args(args)
      mandatory = %i(reporter category created_at revenue organisation upsell source referrer forwarder transport).sort
      raise "keys needed: #{mandatory}" unless args.keys.sort == mandatory
    end

    def check_uniq_args(args)
      mandatory = %i(reporter forwarder source created_at).sort
      raise "keys needed: #{mandatory}" unless args.keys.sort == mandatory
    end

    def add_reporter(hash)
      { reporter: @reporter }.merge(hash)
    end
  end
end
