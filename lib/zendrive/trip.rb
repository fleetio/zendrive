module Zendrive
  class Trip < Findable
    INDEX_ENDPOINT = "driver/{driver_id}/trips"
    SINGLE_ENDPOINT = "driver/{driver_id}/trip/{trip_id}"
    RESOURCE_NAME = "trips"

    attr_reader :id, :trip_id, :info, :score

    def initialize(attributes)
      @id = attributes["driver_id"]
      @trip_id = attributes["trip_id"]
      @info = Util::DeepStruct.new(attributes["info"])
      @score = Util::DeepStruct.new(attributes["score"])
    end

    def self.delete(driver_id, trip_id)
      puts "\n******* #{url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id})}"
      RestClient.delete(url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id, trip_id: trip_id}), default_params)
    end
  end
end
