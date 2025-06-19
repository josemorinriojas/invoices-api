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
      it 'returns paginated invoices with metadata' do
        get :index, format: :json
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)

        expect(json).to have_key('data')
        expect(json['data']).to be_an(Array)

        expect(json).to have_key('meta')
        expect(json['meta']).to include('current_page', 'per_page', 'total_count', 'total_pages')
      end
    end
  end
end
