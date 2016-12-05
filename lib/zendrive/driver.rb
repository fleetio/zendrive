module Zendrive
  class Driver < Findable
    INDEX_ENDPOINT = "drivers"
    SINGLE_ENDPOINT = "driver"
    RESOURCE_NAME = "drivers"

    attr_reader :id, :driver_id, :info, :rank, :score, :recommendation

    def initialize(attributes)
      @id = attributes["driver_id"]
      @driver_id = attributes["driver_id"]
      @info = Util::DeepStruct.new(attributes["info"])
      @rank = attributes["rank"]
      @score = Util::DeepStruct.new(attributes["score"])
      @recommendation = attributes["recommendation"]
    end

    def trips
      Trip.all(driver_id: id)
    end

    def score(params = {})
      Score.find(@id, params)
    end
  end
end
