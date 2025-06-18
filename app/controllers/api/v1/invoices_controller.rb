module Api
  module V1
    class InvoicesController < ApplicationController
      def index
        invoices = load_collection
        render json: invoices
      end

      private

      def load_collection
        @invoices = Invoice.filter_with_cache(params[:start_date], params[:end_date])
      end
    end
  end
end
