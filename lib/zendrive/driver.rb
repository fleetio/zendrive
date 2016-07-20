module Zendrive
  class Driver < Findable
    ENDPOINT = "drivers"

    attr_reader :id, :driver_id, :info, :rank, :score, :recommendation

    def initialize(attributes)
      @id = attributes["id"]
      @driver_id = attributes["driver_id"]
      @info = Util::DeepStruct.new(attributes["info"])
      @rank = attributes["rank"]
      @score = Util::DeepStruct.new(attributes["score"])
      @recommendation = attributes["recommendation"]
    end
  end
end
