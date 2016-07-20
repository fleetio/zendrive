module Zendrive
  class Trip < Findable
    ENDPOINT = "driver/{driver_id}/trips"
    RESOURCE_NAME = "trips"

    attr_reader :id, :trip_id, :info, :score

    def initialize(attributes)
      @id = attributes["driver_id"]
      @trip_id = attributes["trip_id"]
      @info = Util::DeepStruct.new(attributes["info"])
      @score = Util::DeepStruct.new(attributes["score"])
    end
  end
end
