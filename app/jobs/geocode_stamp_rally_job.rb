class GeocodeStampRallyJob < ApplicationJob
  queue_as :default

  def perform(stamp_rally)
    stamp_rally.geocode
  end
end
