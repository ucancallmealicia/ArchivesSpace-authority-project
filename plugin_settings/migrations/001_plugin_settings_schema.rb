Sequel.migration do
  up do

    create_table(:plugin_settings) do
	  primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :repo_id, :null => false
      Integer :user_id, :null => true
      String :user_uniq, :null => false

      MediumBlobField :settings, :null => false

      apply_mtime_columns
    end
  
    alter_table(:plugin_settings) do
      add_foreign_key([:repo_id], :repository, :key => :id)
      add_foreign_key([:user_id], :user, :key => :id)
      add_unique_constraint([:repo_id, :user_uniq], :name => "plugin_settings_uniq")
	end

  end
  down do
    drop_table(:plugin_settings)
  end

end