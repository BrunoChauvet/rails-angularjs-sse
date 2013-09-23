class SharesController < ApplicationController
  include ActionController::Live

  Mime::Type.register "text/event-stream", :stream
  
  def index
    respond_to do |format|
      format.html
      format.stream {
        response.headers['Content-Type'] = 'text/event-stream'
        begin
          loop do
            Share.uncached do
              generate_shares
              response.stream.write "data: #{current_prices.to_json}\n\n"
            end
            sleep 5.second
          end
        rescue IOError
        ensure
          response.stream.close
        end
      }
    end
  end

private
  def generate_shares
    now = Time.now
    companies = Company.all
    companies.each do |company|
      last_share = Share.where(company: company).order('timestamp DESC').first
      new_value = last_share.value + (rand().round(2) - 0.5)
      Share.create(company: company, value: new_value, timestamp: Time.now)
    end
  end

  def current_prices
    current_prices = []
    companies = Company.all(order: :code)
    companies.each do |company|
      share = Share.where(company: company).order('timestamp DESC').first
      previous_share = Share.where('company_id = ? AND timestamp < ?', company.id, share.timestamp).order('timestamp DESC').first
      variation = share.value > previous_share.value ? 'up' : 'down'
      current_prices << {company: company, share: share, variation: variation}
    end
    current_prices
  end
end
