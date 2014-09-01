module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-error", alert: "alert-danger",
      notice: "alert-info" }[flash_type.to_sym] || flash_type
  end
end
