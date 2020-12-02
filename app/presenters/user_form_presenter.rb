class UserFormPresenter < FormPresenter

  def password_field_block(name, label_text, options={})
    if object.new_record?
      super(name, label_text, options)
    end
  end

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << decorated_label(name1, label_text, options)
      m.div(class: "row") do
        m.div(class: "col") do
          m << text_field(name1, options)
        end
        m.div(class: "col") do
          m << text_field(name2, options)
        end
      end
    end
  end
end
