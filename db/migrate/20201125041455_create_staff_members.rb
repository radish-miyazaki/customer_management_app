class CreateStaffMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :staff_members do |t|
      t.string :email, null: false              # メールアドレス
      t.string :family_name, null: false        # 姓（漢字）
      t.string :given_name, null: false         # 名（漢字）
      t.string :family_name_kana, null: false   # 姓（カナ）
      t.string :given_name_kana, null: false    # 名（カナ）
      t.string :hashed_password                 # パスワード
      t.date :start_date, null: false           # 開始日
      t.date :finish_date                       # 終了日
      t.boolean :suspected, null: false, default: false
                                                # 無効フラグ
      t.timestamps                              # データ作成日/更新日
    end

    # LOWER関数を用いてメールアドレスを小文字にしておく
    ## PostgreSQLはインデックスの大文字と小文字を区別してしまうため
    add_index :staff_members, "LOWER(email)", unique: true
    # ソート時に用いるため設定
    add_index :staff_members, [:family_name_kana, :given_name_kana]
  end
end
