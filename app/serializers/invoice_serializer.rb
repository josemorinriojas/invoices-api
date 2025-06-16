class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :invoice_number, :invoice_date, :total, :status
end
