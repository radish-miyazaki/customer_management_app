class StaffMemberFormPresenter < UserFormPresenter
  def suspected_check_box
    markup(:div, class: "form-group form-check") do |m|
      m << check_box(:suspected)
      m << label(:suspected, "アカウント停止")
    end
  end
end
