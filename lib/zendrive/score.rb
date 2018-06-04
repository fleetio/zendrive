module Zendrive
  class Score < Findable
    SINGLE_ENDPOINT = "driver/{driver_id}/score"
    RESOURCE_NAME = "score"

    attr_reader :info, :score, :score_statistics, :start_date, :end_date,
                :driving_behavior

    def initialize(attributes)
      attributes = format_attrs(attributes)
      @info = Util::DeepStruct.new(attributes["info"]) if attributes["info"] && attributes["info"].any?
      @driving_behavior = Util::DeepStruct.new(attributes["driving_behavior"]) if attributes["driving_behavior"] && attributes["driving_behavior"].any?
      @speed_profile = attributes["speed_profile"]
      @start_date = attributes["start_date"]
      @end_date = attributes["end_date"]
    end

    def self.find(driver_id, params)
      req_params = default_params.dup
      req_params[:params].merge!(fields: "info,driving_behavior")
      req_params[:params].merge!(params)

      response = RestClient.get(url_for(self::SINGLE_ENDPOINT, {driver_id: driver_id}), req_params)

      new(JSON.parse(response.body))
    end

    private

    def format_attrs(attributes)
      if attributes["info"] && attributes["info"].any? && attributes["info"]["distance_km"]
        attributes["info"]["distance_in_km"] = attributes["info"]["distance_km"].to_f
        attributes["info"]["distance_in_mi"] = attributes["info"]["distance_km"].to_f * 0.621371
        attributes["info"]["drive_time_in_seconds"] = attributes["info"]["duration_seconds"]
      end

      attributes
    end

    def convert_drive_hours_to_seconds(hours_string)
      if hours_string
        hours, minutes = hours_string.split(":").map(&:to_i)
        (hours * 3600) + (minutes * 60)
      else
        0
      end
    end
  end
end
