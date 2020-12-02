class AddressFormPresenter < FormPresenter
  def postal_code_block(name, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << decorated_label(name, label_text, options)
      m << text_field(name, options)
      m.span "(7桁の半角数字で入力してください)", class: "text-muted ml-2"
    end
  end
end
