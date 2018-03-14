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
      if Zendrive.api_version == "v2"
        @score = Util::DeepStruct.new(attributes["score"]) if attributes["score"] && attributes["score"].any?
      elsif Zendrive.api_version == "v3"
        @driving_behavior = Util::DeepStruct.new(attributes["driving_behavior"]) if attributes["driving_behavior"] && attributes["driving_behavior"].any?
      end

      @simple_path = attributes["simple_path"]
      @speed_profile = attributes["speed_profile"]
      @events = attributes["events"]
    end

    class << self
      def find(driver_id, trip_id)
        params = default_params.dup
        params[:params].merge!({fields: send("#{Zendrive.api_version}_fields")})

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

      private

      def v2_fields
        "info,score,simple_path,events,speed_profile"
      end

      def v3_fields
        "info,driving_behavior,simple_path,events,speed_profile"
      end
    end
  end
end
