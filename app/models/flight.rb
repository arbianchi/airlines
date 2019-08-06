class Flight < ApplicationRecord
    def hours
        (duration/3600.0).round(1)
    end
end
