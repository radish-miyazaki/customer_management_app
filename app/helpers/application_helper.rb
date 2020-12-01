module ApplicationHelper
  include HtmlBuilder

  # タイトルを返すメソッド
  def document_title
    if @title.present?
      "#{@title} - 顧客管理システム"
    else
      "顧客管理システム"
    end
  end
end
