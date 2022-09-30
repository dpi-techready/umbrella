p "Enter a location?"

# Ask the user for their location.
# Get and store the user's location.
# user_location = gets.chomp

user_location = "20 N Wacker Dr"

p "You are in " + user_location + "!"

require "open-uri"

# Get the user's latitude and longitude from the Google Maps API.
gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

# gmaps_api_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

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

first_response = parse_forecast_data.fetch("currently")

second_response = first_response.fetch("summary").to_s

third_response = first_response.fetch("temperature").to_s

# Display the current temperature and summary of the weather for the next hour.
p "It is currently #{third_response}℉ and will be #{second_response} for the hour."
