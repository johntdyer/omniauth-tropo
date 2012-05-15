require 'multi_json'
require 'omniauth-http-basic'

module OmniAuth
  module Strategies
    class Tropo < OmniAuth::Strategies::HttpBasic

      option :title,   "Tropo Login"

      uid { get_value('id') }

      credentials { {:username => username, :password => password}}

      info do
        {
          :name => "#{get_value('firstName')} #{get_value('lastName')}",
          :username => request['username']
        }
      end

      extra do
        {
          :number     => get_value('phoneNumber'),
          :state      => get_value('state'),
          :zip_code   => get_value('postalCode'),
          :join_date  => get_value('joinDate'),
          :job_title  => get_value('jobTitle'),
          :email      => get_value('email'),
          :address    => get_value('address'),
          :address2   => get_value('address2')
        }
      end

      protected

        def api_uri
          "#{options.endpoint}/users/#{username}"
        end

        def json_response
          @json_response ||= MultiJson.load(authentication_response.body, :symbolize_keys => true)
        end

        def get_value(key)
          json_response[key.to_sym]
        end
    end
  end
end
