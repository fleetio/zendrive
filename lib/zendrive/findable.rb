module Zendrive
  class Findable
    ENDPOINT = nil
    def self.all
      response = RestClient.get(
        build_url,
        {params: {apikey: Zendrive.api_key}, accept: :json, content_type: :json}
      )
      records = JSON.parse(response.body)[self::ENDPOINT]
      records.map { |attributes| new(attributes) }
    end

    def self.build_url
      [Zendrive.endpoint, Zendrive.api_version, self::ENDPOINT].join("/")
    end
  end
end
