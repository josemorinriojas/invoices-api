module Api
  module V1
    class InvoicesController < ApplicationController
      include Paginatable

      def index
        invoices = load_collection
        paginate(invoices)
      end

      private

      def load_collection
        Invoice.filter_with_cache(params[:start_date], params[:end_date])
      end
    end
  end
end
