module Publishers
  class Legacy::ShopBrokersWithAdminUrlReportPublisher
    attr_reader :gateway
    def initialize
      @gateway = TransportGateway::Gateway.new(nil, Rails.logger)
    end

    def publish(file_uri)
      process = TransportProfiles::Processes::Legacy::PushShopBrokersWithAdminUrlReport.new(file_uri, @gateway)
      process.execute
    end
  end
end
