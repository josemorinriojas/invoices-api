class Invoice < ApplicationRecord
  self.table_name = 'invoices'

  def self.filter(start_date, end_date)
    return all unless start_date.present? && end_date.present?

    begin
      parsed_start = Date.parse(start_date)
      parsed_end = Date.parse(end_date)
      where(invoice_date: parsed_start..parsed_end)
    rescue ArgumentError
      none
    end
  end
end
