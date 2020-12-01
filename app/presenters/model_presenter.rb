class ModelPresenter
  include HtmlBuilder

  attr_reader :object, :view_context

  # rawメソッドを定義し、view_contextメソッドが返すオブジェクトに委譲される
  delegate :raw, :link_to, to: :view_context 

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end
end