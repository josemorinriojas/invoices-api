require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  describe 'GET #index' do
    let(:start_date) { '2024-01-01' }
    let(:end_date)   { '2024-01-31' }

    before do
      @invoice1 = create(:invoice, invoice_date: '2024-01-10')
      @invoice2 = create(:invoice, invoice_date: '2024-01-20')
    end

    context 'with start_date and end_date' do
      it 'returns http success' do
        get :index, params: { start_date: start_date, end_date: end_date }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'returns the filtered invoices' do
        expect(Invoice).to receive(:filter_with_cache).with(start_date, end_date).and_call_original
        get :index, params: { start_date: start_date, end_date: end_date }, format: :json

        json = JSON.parse(response.body)
        expect(json.size).to eq(2)
      end
    end

    context 'without dates' do
      it 'still returns success and falls back to defaults' do
        get :index, format: :json
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json).to be_an(Array)
      end
    end
  end
end
