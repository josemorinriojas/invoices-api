class Invoice < ApplicationRecord
  include CacheableQuery

  enum :status, active: "Vigente", cancelled: "Cancelado"

  def self.filter_with_cache(start_date, end_date)
    return all unless start_date.present? && end_date.present?

    parsed_start, parsed_end = parse_dates(start_date, end_date)
    return none unless parsed_start && parsed_end

    key = cache_key_for("invoices", parsed_start, parsed_end)

    fetch_cache(key) do
      where(invoice_date: parsed_start..parsed_end).map(&:attributes)
    end.map { |attrs| new(attrs) }
  end

  def self.top_sales_days(limit = 10)
    active
      .group("DATE(invoice_date)")
      .select("DATE(invoice_date) as day, SUM(total) as total_sales")
      .order("SUM(total) DESC")
      .limit(limit)

  end

  private

  def self.parse_dates(start_date, end_date)
    [
      Date.parse(start_date).beginning_of_day.in_time_zone,
      Date.parse(end_date).end_of_day.in_time_zone
    ]
  rescue ArgumentError => e
    Rails.logger.error "Invalid date format: #{e.message}"
    [nil, nil]
  end
end
