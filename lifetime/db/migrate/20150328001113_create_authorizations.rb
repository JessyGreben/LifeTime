class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :refresh_token
      t.references :user, index: true

      t.timestamps
    end
  end
end
