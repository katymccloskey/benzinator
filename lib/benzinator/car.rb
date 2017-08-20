require 'faraday'
require 'json'

API_URL = "https://trailapi-trailapi.p.mashape.com/"

module Benzinator
  class Car
    attr_reader :city, :state, :country, :name, :unique_id, :directions, :lat, :lon, :description, :date_created, :children, :activities

    def initialize(attributes)
      @city = attributes["city"]
      @state = attributes["state"]
      @country = attributes["country"]
      @name = attributes["name"]
      @unique_id = attributes["unique_id"]
      @directions = attributes["directions"]
      @lat = attributes["lat"]
      @lon = attributes["lon"]
      @description = attributes["description"]
      @date_created = attributes["date_created"]
      @children = attributes["children"]
      @activities = attributes["activities"]
    end

    def self.find(city)
      response = Faraday.get("#{API_URL}/#{city}")
      attributes = JSON.parse(response.body)
      new(attributes)
    end

    def self.all
      response = Faraday.get(API_URL)
      cars = JSON.parse(response.body)
      cars.map { |attributes| new(attributes) }
    end
  end
end
