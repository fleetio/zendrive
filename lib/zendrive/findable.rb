module Zendrive
  class Findable
    ENDPOINT = nil
    RESOURCE_NAME = nil

    def self.all(interpolated_params = nil)
      response = RestClient.get(
        build_url(interpolated_params),
        {params: {apikey: Zendrive.api_key}, accept: :json, content_type: :json}
      )
      records = JSON.parse(response.body)[self::RESOURCE_NAME]
      records.map { |attributes| new(attributes) }
    end

    # Combine the top level API endpoint with the version and the resource specific endpoint
    def self.build_url(interpolated_params)
      [Zendrive.endpoint, Zendrive.api_version, (endpoint_with_params(interpolated_params))].join("/")
    end

    # Replace any parameters that need to be interpolated.
    # Ex: /driver/{driver_id}/trips -> /driver/123/trips
    def self.endpoint_with_params(params)
      endpoint = self::ENDPOINT

      if params
        params.each do |name, value|
          endpoint.gsub!("{#{name}}", value)
        end
      end

      endpoint
    end
  end
end
