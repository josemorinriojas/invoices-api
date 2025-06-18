require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe '.filter_with_cache' do
    let(:start_date) { '2024-06-01' }
    let(:end_date) { '2024-06-30' }

    before do
      # Limpia Redis antes de cada test
      $redis.flushdb

      # Facturas dentro del rango y activas
      create(:invoice, invoice_date: '2024-06-10', total: 1000, status: "Vigente")
      create(:invoice, invoice_date: '2024-06-15', total: 2000, status: "Vigente")

      # Factura fuera de rango
      create(:invoice, invoice_date: '2024-07-01', total: 500, status: "Vigente")
    end

    it 'retorna las facturas dentro del rango y cachea el resultado' do
      result = Invoice.filter_with_cache(start_date, end_date)

      expect(result.size).to eq(2)
      expect(result.map(&:total)).to include(1000, 2000)

      key = Invoice.send(:cache_key_for, "invoices", Date.parse(start_date).beginning_of_day, Date.parse(end_date).end_of_day)
      expect($redis.get(key)).to be_present
    end
  end

  describe '.top_sales_days' do
    before do
        # Día con suma 3000 (debería estar en top)
        create(:invoice, invoice_date: '2024-06-10', total: 1000, status: "Vigente")
        create(:invoice, invoice_date: '2024-06-10', total: 2000, status: "Vigente")

        # Día con suma 9999 pero cancelada (no debe contar)
        create(:invoice, invoice_date: '2024-06-15', total: 9999, status: "Cancelado")

        # Crea 10 días adicionales con totales crecientes
        (1..10).each do |i|
        create(:invoice, invoice_date: "2024-06-#{i.to_s.rjust(2, '0')}", total: i * 100, status: "Vigente")
        end
    end

    it 'retorna solo días con facturas activas y suma sus totales' do
      result = Invoice.top_sales_days(10)

      expect(result.to_a.size).to eq(10)
      expect(result.first.day.to_s).to eq('2024-06-10')
      expect(result.first.total_sales.to_f).to eq(4000.0)
    end
  end
end
