module PaymentProcessor
    def self.client
        Spreedly::Environment.new(ENV['ENVIRONMENT_KEY'], ENV['ACCESS_SECRET'])
    end
end