class ChangeDatatypeStatusOfTasks < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :status, 'integer USING CAST(status AS integer)'
  end
  def down
    change_column :tasks, :status, :string
  end
end
