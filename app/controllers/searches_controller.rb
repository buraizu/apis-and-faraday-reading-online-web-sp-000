class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin   # Not sure about this...
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'GSJJQCVC1ZOQGLOCMJPZYAUQDBW03ALG4WO41LWSQLTYHVAZ'
      req.params['client_secret'] = 'SEA2YZQXFXILJFCHSBYQZ1UTEP3K4PKYXLSYBLVMZVVWMR4L'
      req.params['v'] = '20190125'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body['response']['venues']
    else
      @error = body['meta']['errorDetail']
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
    render 'search'
  end
end


# body_hash = JSON.parse(@resp.body)
# @venues = body_hash["response"]["venues"]
# render 'search'
