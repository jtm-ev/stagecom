class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.text :user
      t.text :buttons

      t.timestamps
    end
  end
end
