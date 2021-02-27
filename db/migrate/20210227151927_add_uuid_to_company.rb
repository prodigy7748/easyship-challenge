class AddUuidToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :uuid, :string
  end
end
