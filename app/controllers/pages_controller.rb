require 'net/http'

class PagesController < ApplicationController
	def hello
		puts "hello"
	end

	def index

	end

	def show
		puts "-------"
		puts "showugh"
		puts "-------"

	end

	def action
		uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?")
		params = {:location => "37.3541,121.9552",
			:radius => 5000,
			:key => "AIzaSyBerzpGCWvdFaDT35uExzJsYf_ISbWsygU"
		}
		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		res = http.request(request)	

		@result = JSON.parse(res.body)
		@result.each do |key, val|
			if key == "status"
				stat = val
			elsif key == "results"
				val.each do |v|
					puts v["geometry"]["location"]
					puts v["icon"]
					puts v["id"]
					puts v["name"]
					puts v["types"]
					puts v["vicinity"]
				end
			end
		end
	end

	def get_yelp_token
		uri = URI("https://api.yelp.com/oauth2/token")
		params = {:grant_type => "client_credentials",
			:client_id => "T73HeUryjWoqpfjZjnpglw",
			:client_secret => "pGynGKHnr1kLLOTL9j8MKE08hLXi7cmT3QgpXDPw4M1CBaYzR3e6OUL2OLhwKHRI"
		}

		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Post.new(uri.request_uri)
		res = http.request(request)	
		@yelp_token = JSON.parse(res.body)
		puts @yelp_token
	end

	def search_yelp
		search_query = params['search_query']

		uri = URI("https://api.yelp.com/v3/businesses/search")
		params = {:term => search_query,
			:latitude => "37.3541",
			:longitude => "-121.9552"
		}

		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		yelp_token = "th-MZnbwTFwSnW3tneL6XyByaxJoO9px5_FZ19r_gSAaEYDND_61ELwfiMIhmLO0qHJ7jWqNtyRhBIkTMqeRC4NMIhgBz_LY6YPeWrq8U0zQvsyPp7Jiwd3oQWt2WXYx"
		request['authorization'] = "Bearer #{yelp_token}"

		res = http.request(request)	
		@yelp_result = JSON.parse(res.body)
	end

	# def view_details
	# 	latitude = params[:location][:latitude]
	# 	longitude = params[:location][:longitude]
	# 	name = params[:name]


	# 	uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?")
	# 	params = {:location => "#{latitude},#{longitude}",
	# 		:radius => 50,
	# 		:keyword => name,
	# 		:key => "AIzaSyBerzpGCWvdFaDT35uExzJsYf_ISbWsygU"
	# 	}
	# 	uri.query = URI.encode_www_form(params)

	# 	http = Net::HTTP.new(uri.host, uri.port)
	# 	http.use_ssl = true
	# 	http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
	# 	request = Net::HTTP::Get.new(uri.request_uri)
	# 	res = http.request(request)	

	# 	@google_result = JSON.parse(res.body)

	# 	puts "-----------"
	# 	puts @google_result
	# 	puts "-----------"

	# 	place_id = @google_result["results"][0]["place_id"]


	# 	## => place details stuff
	# 	uri = URI("https://maps.googleapis.com/maps/api/place/details/json?")
	# 	params = {:placeid => place_id,
	# 		:key => "AIzaSyBerzpGCWvdFaDT35uExzJsYf_ISbWsygU"
	# 	}
	# 	uri.query = URI.encode_www_form(params)

	# 	http = Net::HTTP.new(uri.host, uri.port)
	# 	http.use_ssl = true
	# 	http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
	# 	request = Net::HTTP::Get.new(uri.request_uri)
	# 	res = http.request(request)	

	# 	@place_details = JSON.parse(res.body)
	# end
	def view_details
		id = params[:id]
		uri = URI("https://api.yelp.com/v3/businesses/#{id}")
		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		yelp_token = "th-MZnbwTFwSnW3tneL6XyByaxJoO9px5_FZ19r_gSAaEYDND_61ELwfiMIhmLO0qHJ7jWqNtyRhBIkTMqeRC4NMIhgBz_LY6YPeWrq8U0zQvsyPp7Jiwd3oQWt2WXYx"
		request['authorization'] = "Bearer #{yelp_token}"

		res = http.request(request)	
		@yelp_details = JSON.parse(res.body)
		

		uri = URI("https://api.yelp.com/v3/businesses/#{id}/reviews")
		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		request['authorization'] = "Bearer #{yelp_token}"

		res = http.request(request)	
		@yelp_reviews = JSON.parse(res.body)

	end

	def search_google
		search_query = params['search_query']
		uri = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?")
		params = {:keyword => search_query,
			:key => "AIzaSyBerzpGCWvdFaDT35uExzJsYf_ISbWsygU",
			:location => "37.3541,-121.9552",
			:radius => 5000,
		}
		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		res = http.request(request)	

		@google_result = JSON.parse(res.body)
	end

	def autocomplete
		search_query = params['text']
		uri = URI("https://api.yelp.com/v3/autocomplete")
		params = {:text => search_query,
				:latitude => "37.3541",
				:longitude => "-121.9552"
			}
		uri.query = URI.encode_www_form(params)

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
		request = Net::HTTP::Get.new(uri.request_uri)
		yelp_token = "th-MZnbwTFwSnW3tneL6XyByaxJoO9px5_FZ19r_gSAaEYDND_61ELwfiMIhmLO0qHJ7jWqNtyRhBIkTMqeRC4NMIhgBz_LY6YPeWrq8U0zQvsyPp7Jiwd3oQWt2WXYx"
		request['authorization'] = "Bearer #{yelp_token}"

		res = http.request(request)	
		@autocomplete = JSON.parse(res.body)


	end
end

			#<%= v["coordinates"] %> 
			#<%= v["distance"] %>
			#<%= v["is_closed"] %>
			#<%= v["transactions"] %>
		
