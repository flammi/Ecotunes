class CreateImportJobs < ActiveRecord::Migration
  def change
    create_table :import_jobs do |t|
      t.integer :filecount
      t.integer :filecount_processed
      t.text :files
      t.boolean :picked

      t.timestamps
    end
  end
end
