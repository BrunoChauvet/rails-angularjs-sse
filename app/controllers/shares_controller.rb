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
              response.stream.write "data: #{generate_new_values.to_json}\n\n"
            end
            sleep 5.second
          end
        rescue IOError # Raised when browser interrupts the connection
        ensure
          response.stream.close # Prevents stream from being open forever
        end
      }
    end
  end

private
  def generate_new_values
    now = Time.now
    current_values = []

    companies = Company.all(order: :code)
    companies.each do |company|
      previous_share = Share.where(company: company).order('timestamp DESC').first
      new_value = previous_share.value + (rand().round(2) - 0.5)
      share = Share.create(company: company, value: new_value, timestamp: Time.now)
      variation = share.value > previous_share.value ? 'up' : 'down'
      current_values << {company: company, share: share, variation: variation}
    end
    current_values
  end
end
