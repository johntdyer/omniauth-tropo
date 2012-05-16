%w(omniauth-http-basic multi_json faraday).each{|lib| require lib}

module OmniAuth
  module Strategies
    class Tropo < OmniAuth::Strategies::HttpBasic

      option :title,   "Tropo Login"

      option :role_options, {
        :path            =>  'roles',
        :admin_username  =>  nil,
        :admin_password  =>  nil
      }

      uid { get_value(:id) }

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
          :address2   => get_value('address2'),
          :roles      => roles_enabled ? fetch_roles : nil
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

      def roles_enabled
        if options.role_options.admin_username && options.role_options.admin_username
          true
        else
          false
        end
      end

      def fetch_roles
        conn = Faraday.new(:url => options.endpoint) do |builder|
          builder.request  :url_encoded
          builder.response :logger
          builder.adapter  :net_http
        end
        conn.basic_auth(options.role_options.admin_username,options.role_options.admin_password)
        response = conn.get "/users/#{request['username']}/#{options.role_options.path}"
        MultiJson.load(response.body).collect{|x| x["roleName"]} if response.status == 200
      end
    end
  end
end
