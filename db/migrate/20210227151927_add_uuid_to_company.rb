class AddUuidToCompany < ActiveRecord::Migration[6.0]
  def change
    remove_reference :shipments, :company, index: false
    remove_column :companies, :id, :integer
    add_column    :companies, :id, :string, primary_key: true, null: false
    add_reference :shipments, :company, foreign_key: true, type: :string, null: false
  end
end
