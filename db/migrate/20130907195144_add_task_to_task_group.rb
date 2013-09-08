class AddTaskToTaskGroup < ActiveRecord::Migration
  def change
    add_reference :tasks, :task_group, index: true
  end
end
