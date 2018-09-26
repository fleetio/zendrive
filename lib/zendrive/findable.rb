module Zendrive
  class Findable
    INDEX_ENDPOINT = nil
    SINGLE_ENDPOINT = nil
    RESOURCE_NAME = nil

    def self.all(interpolated_params = nil, query_params = {})
      params = default_params.dup
      params[:params].merge!(query_params)

      response = RestClient.get(url_for(self::INDEX_ENDPOINT, interpolated_params), params)
      records = JSON.parse(response.body)[self::RESOURCE_NAME]
      records.map { |attributes| new(attributes) }
    end

    # Combine the top level API endpoint with the version and the resource specific endpoint
    def self.url_for(endpoint, interpolated_params)
      [Zendrive.endpoint, "v3", (interpolated_endpoint(endpoint, interpolated_params))].join("/")
    end

    # Required on all API calls
    def self.default_params
      {
        accept: :json,
        content_type: :json,
        params: { apikey: Zendrive.api_key, limit: 50, start_date: (Date.today - 6.months).to_s, end_date: Date.today.to_s }
      }
    end

    # Replace any parameters that need to be interpolated.
    # Ex: /driver/{driver_id}/trips -> /driver/123/trips
    def self.interpolated_endpoint(endpoint, params)
      local_endpoint = endpoint.dup
      if params
        params.each do |name, value|
          local_endpoint.gsub!("{#{name}}", "#{value}")
        end
      end

      local_endpoint
    end
  end
end
