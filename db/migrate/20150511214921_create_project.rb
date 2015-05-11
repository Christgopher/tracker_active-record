class CreateProject < ActiveRecord::Migration
  def change
    create_table(:projects) do |t|
      t.column(:name, :string)
    end

    add_column(:employees, :project_id, :integer)  
  end
end
