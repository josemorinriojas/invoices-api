class CreateInvoiceTable < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_tables do |t|
      t.string :invoice_number
      t.decimal :total, precision: 15, scale: 2
      t.datetime :invoice_date
      t.string :status

      t.timestamps
    end
  end
end
