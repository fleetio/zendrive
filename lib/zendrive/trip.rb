module Zendrive
  class Trip < Findable
    INDEX_ENDPOINT = "driver/{driver_id}/trips"
    SINGLE_ENDPOINT = "driver/{driver_id}/trip/{trip_id}"
    RESOURCE_NAME = "trips"

    attr_reader :id, :trip_id, :info, :score, :simple_path, :events,
                :speed_profile, :driving_behavior

    def initialize(attributes)
      @id = attributes["trip_id"]
      @trip_id = attributes["trip_id"]

      @info = Util::DeepStruct.new(attributes["info"]) if attributes["info"] && attributes["info"].any?
      @driving_behavior = Util::DeepStruct.new(attributes["driving_behavior"]) if attributes["driving_behavior"] && attributes["driving_behavior"].any?

      @simple_path = attributes["simple_path"]
      @speed_profile = attributes["speed_profile"]
      @events = attributes["events"]
    end

    class << self
      def find(driver_id, trip_id)
        params = default_params.dup
        params[:params].merge!(fields: "info,driving_behavior,simple_path,events,speed_profile")

        response = RestClient.get(
          url_for(SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id}),
          params
        )

        new(JSON.parse(response.body))
      end

      def delete(driver_id, trip_id)
        begin
          response = RestClient.delete(url_for(SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id}), default_params)
        rescue => e
          response = e.response
        end

        response.code == 200
      end
    end
  end
end
