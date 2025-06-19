# app/controllers/concerns/paginatable.rb
module Paginatable
  extend ActiveSupport::Concern

  included do
    # Método para paginar cualquier colección (ActiveRecord::Relation o Array)
    def paginate(collection)
      page = (params[:page] || 1).to_i
      per_page = (params[:per_page] || 10).to_i

      paginated_collection = if collection.is_a?(Array)
                               Kaminari.paginate_array(collection).page(page).per(per_page)
                             else
                               collection.page(page).per(per_page)
                             end

      render json: {
        data: paginated_collection,
        meta: {
          current_page: paginated_collection.current_page,
          per_page: paginated_collection.limit_value,
          total_count: paginated_collection.total_count,
          total_pages: paginated_collection.total_pages
        }
      }
    end
  end
end
