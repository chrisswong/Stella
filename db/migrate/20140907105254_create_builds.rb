class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :number
      t.string :version
      t.text :releaseNotes
      t.string :platform
      t.string :buildIdenifier
      t.string :accessToken
      t.string :domain
      t.string :provision
      t.string :displayname
      t.string :icon
      t.string :buildFilePath

      t.timestamps
    end
  end
end
