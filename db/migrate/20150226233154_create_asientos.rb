class CreateAsientos < ActiveRecord::Migration
  def change
    create_table :asientos do |t|
      t.string :posicion
      t.integer :sala

      t.timestamps
    end
  end
end
