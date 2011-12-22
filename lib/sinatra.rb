require 'sinatra/base'
require 'sinatra/namespace'
require 'active_record'

module API
  class Sinatra < Sinatra::Base
    
    configure do
      ActiveRecord::Base.configurations = YAML::load(IO.read('config/database.yml'))
      ActiveRecord::Base.establish_connection(settings.environment)
    end
    
    helpers do
      def success(data={}, format='json', headers={})
        output = (data == :empty ? '' : data.to_json)
        return [200, headers, output]
      end
      def failure(message, code='', http_code=500, headers={}, backtrace=nil)
        obj = {:code => code, :message => message, :backtrace => backtrace}
        return [http_code, headers, obj.to_json]
      end
    end
    
    not_found do
      failure("The URL you are trying to access does not exists. Poop!", 'PAGE_NOT_FOUND', 404, {}, env['sinatra.error'].backtrace.join("\n"))
    end
    error do
      failure(env['sinatra.error'].message, 'ERR_UNKNOWN', 500, {}, env['sinatra.error'].backtrace.join("\n"))
    end
    
  end
end