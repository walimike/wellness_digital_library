module ApplicationHelper
  def toggle_sort_direction(column)
    params[:sort] == column && params[:direction] == "asc" ? "desc" : "asc"
  end
end
