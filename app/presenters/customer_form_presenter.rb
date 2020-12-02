class CustomerFormPresenter < UserFormPresenter
  def gender_field_block
    markup do |m|
      m << decorated_label(:gender, "性別")
      m.div(class: "form-check pb-3") do |n|
        n.div(class: "form-check-inline") do |l|
          l << radio_button(:gender, "male", class: "form-check-input")
          l << label(:gender_male, "男性", class: "form-check-label")
          l << radio_button(:gender, "female", class: "form-check-input ml-3")
          l << label(:gender_female, "女性", class: "form-check-label")
        end
      end
    end
  end
end
