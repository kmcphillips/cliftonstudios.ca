module Enumerable
  def paginate?
    respond_to?(:total_pages) && total_pages > 1
  end
end

