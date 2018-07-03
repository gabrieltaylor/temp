class AddCallsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :calls do |t|
      t.string :call_control_id
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
