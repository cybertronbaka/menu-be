# frozen_string_literal: true

module GqlPagination
  extend ActiveSupport::Concern

  included do
    argument :page, Integer, required: false
    argument :per_page, Integer, required: false
  end

  def paginate(list, body_root, page = arguments[:page]&.to_i, per_page = arguments[:per_page]&.to_i)
    collection = list.page(page || 1).per(per_page || 10)
    {
      "#{body_root}": collection,
      page_info: page_meta(collection)
    }
  end

  def page_meta(collection)
    {
      total_count: collection.total_count,
      limit_value: collection.limit_value,
      total_pages: collection.total_pages,
      current_page: collection.current_page
    }
  end
end