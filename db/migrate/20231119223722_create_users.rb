class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.integer :fractal_id, null: false, index: { unique: true }
      t.string :token_dg, null: false, index: { unique: true }
      t.string :photo_url, null: true
      t.string :status, default: 'active'
      t.string :role

      t.timestamps
    end
  end
end
