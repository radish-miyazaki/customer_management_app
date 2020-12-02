class FormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context

  delegate  :label, :text_field, :date_field, :password_field,
            :check_box, :radio_button, :text_area, :object, to: :form_builder
  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
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
end
