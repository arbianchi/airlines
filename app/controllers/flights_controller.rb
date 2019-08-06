class FlightsController < ApplicationController
    def index 
        @flights = Flight.all
    end

    def purchase
        print 'PURCHASING'
    end
end