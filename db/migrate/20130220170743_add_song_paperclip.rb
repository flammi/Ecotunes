class AddSongPaperclip < ActiveRecord::Migration
  def self.up
    add_column :songs, :song_file_name, :string
    add_column :songs, :song_content_type, :string
    add_column :songs, :song_file_size, :integer
    add_column :songs, :song_updated_at, :datetime
  
  
  end

  def self.down
    remove_column :songs, :song_file_name
    remove_column :songs, :song_content_type
    remove_column :songs, :song_file_size
    remove_column :songs, :song_updated_at

  end
end
