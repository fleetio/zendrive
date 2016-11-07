module Zendrive
  class Trip < Findable
    INDEX_ENDPOINT = "driver/{driver_id}/trips"
    SINGLE_ENDPOINT = "driver/{driver_id}/trip/{trip_id}"
    RESOURCE_NAME = "trips"

    attr_reader :id, :trip_id, :info, :score, :simple_path, :events, :speed_profile

    def initialize(attributes)
      @id = attributes["trip_id"]
      @trip_id = attributes["trip_id"]

      @info = Util::DeepStruct.new(attributes["info"]) if attributes["info"] && attributes["info"].any?
      @score = Util::DeepStruct.new(attributes["score"]) if attributes["score"] && attributes["score"].any?

      @simple_path = attributes["simple_path"]
      @speed_profile = attributes["speed_profile"]
      @events = attributes["events"]
    end

    def self.find(driver_id, trip_id)
      params = default_params.dup
      params[:params].merge!({fields: "info,score,simple_path,events,speed_profile"})

      response = RestClient.get(
        url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id}),
        params
      )

      new(JSON.parse(response.body))
    end

    def self.delete(driver_id, trip_id)
      begin
        response = RestClient.delete(url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id}), default_params)
      rescue => e
        response = e.response
      end

      response.code == 200
    end
  end
end
