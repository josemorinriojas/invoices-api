class DailyTopSalesReportJob
  include Sidekiq::Worker
  queue_as :default

  def perform(email = ENV['DEFAULT_REPORT_EMAIL'])
    return unless email.present?

    DailyTopSalesMailer.daily_report(email).deliver_later
  rescue => e
    Rails.logger.error("Error sending daily top sales report: #{e.message}")
    raise e
  end
end
