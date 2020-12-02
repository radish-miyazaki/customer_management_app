class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|

      t.string :email, null: false # メールアドレス
      t.string :family_name, null: false # 姓
      t.string :given_name, null: false # 名
      t.string :family_name_kana, null: false # 性（フリガナ）
      t.string :given_name_kana, null: false # 名(フリガナ)
      t.string :gender # 性別
      t.date :birthday # 誕生日
      t.string :hashed_password # 顧客用のパスワード
      
      t.timestamps
    end
    add_index :customers, "LOWER(email)", unique: true
    add_index :customers, [ :family_name_kana, :given_name_kana ] # 検索用・ソート用インデックス
  end
end
