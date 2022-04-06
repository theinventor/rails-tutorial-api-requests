class NasaImagesController < ApplicationController
  def welcome
    client = Faraday.get("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=#{Rails.application.credentials.nasa_key}")
    @images = JSON.parse(client.body)['photos']

    city = params[:city] || 'seattle'
    city_search_url = "http://api.openweathermap.org/geo/1.0/direct?q=#{city}&appid=#{Rails.application.credentials.weather_api_key}"
    city_result = Faraday.get city_search_url


    lat = JSON.parse(city_result.body).first['lat'] || '47.123'
    longitude = JSON.parse(city_result.body).first['lon'] || '-122.123'
    weather_url = "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{longitude}&appid=#{Rails.application.credentials.weather_api_key}&units=imperial"
    @weather_result = Faraday.get weather_url
  end
end
