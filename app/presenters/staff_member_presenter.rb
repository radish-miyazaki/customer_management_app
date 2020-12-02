class StaffMemberPresenter < ModelPresenter

  delegate :suspected?, to: :object

  # 職員の無効フラグのON/OFFを表現する記号を返す
  # ON : BALLOT BOX WITH CHECK (U*2611)
  # OFF : BALLOT BOX (U*2610)
  def suspected_mark
    suspected? ? raw("&#x2611;") : raw("&#x2610;")
  end

  # 職員の氏名全体を生成する fn : 姓、 gn : 名
  def full_name(fn, gn)
    fn + ' ' + gn
  end

end
