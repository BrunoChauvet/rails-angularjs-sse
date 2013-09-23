class CreateSchema < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :code
      t.string :name

      t.timestamps
    end

    create_table :shares do |t|
      t.belongs_to :company
      t.decimal :value
      t.timestamp :timestamp

      t.timestamps
    end

    add_foreign_key :shares, :company_id
    add_index :shares, [:company_id]
  end
end
