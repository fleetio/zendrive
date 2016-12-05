module Zendrive
  class Score < Findable
    SINGLE_ENDPOINT = "driver/{driver_id}/score"
    RESOURCE_NAME = "score"

    attr_reader :info, :score, :score_statistics, :start_date, :end_date

    def initialize(attributes)
      @info = Util::DeepStruct.new(attributes["info"]) if attributes["info"] && attributes["info"].any?
      @score = Util::DeepStruct.new(attributes["score"]) if attributes["score"] && attributes["score"].any?
      @score_statistics = Util::DeepStruct.new(attributes["score_statistics"]) if attributes["score_statistics"] && attributes["score_statistics"].any?
      @speed_profile = attributes["speed_profile"]
      @start_date = attributes["start_date"]
      @end_date = attributes["end_date"]
    end

    def self.find(driver_id, params)
      req_params = default_params.dup
      req_params[:params].merge!(params)
      req_params[:params].merge!({fields: "info,score,score_statistics"})

      response = RestClient.get(url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id}), req_params)

      new(JSON.parse(response.body))
    end
  end
end
