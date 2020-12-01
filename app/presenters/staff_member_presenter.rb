class StaffMemberPresenter < ModelPresenter

  delegate :suspected?, to: :object

  # 職員の無効フラグのON/OFFを表現する記号を返す
  # ON : BALLOT BOX WITH CHECK (U*2611)
  # OFF : BALLOT BOX (U*2610)
  def suspected_mark
    suspected? ? raw("&#x2611;") : raw("&#x2610;")
  end

end
