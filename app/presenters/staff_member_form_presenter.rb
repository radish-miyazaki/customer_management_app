class StaffMemberFormPresenter < FormPresenter

  def full_name_block(name1, name2, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << label(name1, label_text, class: "ml-2")
      if options[:required]
        m.span("必須", class: "badge badge-danger ml-2")
      end
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

  def text_field_block(name, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << label(name, label_text, class: "ml-2")
      if options[:required]
        m.span("必須", class: "badge badge-danger ml-2")
      end
      m << text_field(name, options)
    end
  end

  def password_field_block(name, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << label(name, label_text, class: "ml-2")
      if options[:required]
        m.span("必須", class: "badge badge-danger ml-2")
      end
      m << password_field(name, options)
    end
  end

  def date_field_block(name, label_text, options = {})
    markup(:div, class: "form-group") do |m|
      m << label(name, label_text, class: "ml-2")
      if options[:required]
        m.span("必須", class: "badge badge-danger ml-2")
      end
      m << date_field(name, options)
    end
  end

  def suspected_check_box
    markup(:div, class: "form-group form-check") do |m|
      m << check_box(:suspected)
      m << label(:suspected, "アカウント停止")
    end
  end
end