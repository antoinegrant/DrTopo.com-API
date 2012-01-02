require 'sinatra/base'
require 'sinatra/namespace'
require 'active_record'

module API
  class Sinatra < Sinatra::Base
    
    set :environment, (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
    
    configure do
      ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
      ActiveRecord::Base.establish_connection(settings.environment)
    end
    
    helpers do
      
      def success(options={
        :data    => nil,
        :format  => 'json',
        :headers => {}
      })
        if defined?(options['data']) && !options['data'].nil?
          options['format'] = (!defined?(options['format']) || options['format'].nil? || options['format'] == '' ? 'json' : options['format'])
          case options['format']
          when 'xml'
            options['data'] = options['data'].to_xml
          else
            options['data'] = options['data'].to_json
          end
          output = options['data']
        else
          output = 'Success'
        end
        return [200, options['headers'], output]
      end
      
      def failure(options={
        'message'   => 'Error',
        'format'    => 'json',
        'code'      => 'ERROR_GENERAL',
        'http_code' => 500,
        'headers'   => {},
        'backtrace' => {}
      })
        options['format'] = (!defined?(options['format']) || options['format'].nil? || options['format'] == '' ? 'json' : options['format'])
        obj = {:code => options['code'], :message => options['message'], :backtrace => options['backtrace']}
        case options['format']
        when 'xml'
          obj = obj.to_xml
        else
          obj = obj.to_json
        end
        return [options['http_code'], options['headers'], obj]
      end
      
    end
    
    not_found do
      failure({'message' => 'The URL you are trying to access does not exists. Poop!', 'code' => 'PAGE_NOT_FOUND', 'http_code' => 404, 'backtrace' => env['sinatra.error'].backtrace.join("\n")})
    end
    
    error do
      failure({'message' => env['sinatra.error'].message, 'code' => 'ERR_UNKNOWN', 'http_code' => 500, 'backtrace' => env['sinatra.error'].backtrace.join("\n")})
    end
    
    get '/' do
      success({'data' => "This is a base Sinatra app!"})
    end
    
    get '/env' do
      success({'data' => {'env' => settings.environment}})
    end
    
  end
end