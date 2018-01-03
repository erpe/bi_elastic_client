Gem::Specification.new do |s|
  s.name        = 'bi_elastic_client'
  s.version     = '0.1'
  s.date        = '2018-01-02'
  s.summary     = 'a client for bi/elasticsearch'
  s.description = 'the client is used to report events/uniqs to elasticsearch'
  s.authors     = ['rene paulokat']
  s.email       = 'rene@so36.net'
  s.files       = ['lib/bi_elastic.rb',
                   'lib/bi_elastic/railtie.rb',
                   'lib/generators/bi_elastic/init_generator.rb',
                   'lib/generators/bi_elastic/job_generator.rb']

  s.add_runtime_dependency 'elasticsearch', '~> 6.0'
  s.requirements << 'an existing rails app'
  s.license = 'MIT'
end
