class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.text :body
      t.string :author

      t.timestamps
    end
  end
end
