class AddAuthTokenToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :auth_token, :string
  end
end
