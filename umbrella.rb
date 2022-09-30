p "Enter a location?"

# Ask the user for their location.
# Get and store the user's location.
user_location = gets.chomp

# user_location = "20 N Wacker Dr"

p "You are in " + user_location + "!"

require "open-uri"

# Get the user's latitude and longitude from the Google Maps API.
gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

raw_gmaps_data = URI.open(gmaps_api_url).read

require "json"

parse_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parse_gmaps_data.fetch("results")

first_result = results_array.at(0)

result_hash = first_result.fetch("geometry")

second_result = result_hash.fetch("location")

latitude = second_result.fetch("lat").to_s
longitude = second_result.fetch("lng").to_s

p "Your coordinates are " + latitude + ", " + longitude + "."

# Get the weather at the user's coordinates from the Dark Sky API.
ds_api_url = "https://api.darksky.net/forecast/26f63e92c5006b5c493906e7953da893/#{latitude},#{longitude}"

raw_forecast_data = URI.open(ds_api_url).read

parse_forecast_data = JSON.parse(raw_forecast_data)

currently_response = parse_forecast_data.fetch("currently")

hourly_response = parse_forecast_data.fetch("hourly")

data_response_array = hourly_response.fetch("data")

temperature_response = currently_response.fetch("temperature").to_s

summary_response = currently_response.fetch("summary")

# Display the current temperature and summary of the weather for the next hour.
p "It is currently #{temperature_response}℉ and will be #{summary_response} for the hour."

# For each of the next twelve hours, check if the precipitation probability is greater than 10%.
# If so, print a message saying how many hours from now and what the precipitation probability is.

i = 2
precip_probabilities = 0

data_response_array.each {|x|
  p Time.at(x.fetch("time"))
  p x.fetch("precipProbability")
  precip_probabilities = x.fetch("precipProbability")
  i += 1
  if i > 13
    break
end
}

if precip_probabilities > 0.10
  p "You might want to carry an umbrella!"
else 
  p "You probably won't need an umbrella today."
end

# If any of the next twelve hours has a precipitation probability greater than 10%, print "You might want to carry an umbrella!"
# If not, print "You probably won't need an umbrella today."
