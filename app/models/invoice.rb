class Invoice < ApplicationRecord
  self.table_name = 'invoices'

  def self.filter(start_date, end_date)
    return all unless start_date.present? && end_date.present?

    begin
      parsed_start = Date.parse(start_date).beginning_of_day.in_time_zone
      parsed_end = Date.parse(end_date).end_of_day.in_time_zone

      where(invoice_date: parsed_start..parsed_end)
    rescue ArgumentError
      none
    end
  end

  def self.top_sales_days(limit = 10)
    group("DATE(invoice_date)")
      .select("DATE(invoice_date) as day, SUM(total) as total_sales")
      .order("total_sales DESC")
      .limit(limit)
  end
end
