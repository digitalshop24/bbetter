class CreateChannelType < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TYPE channel AS ENUM ('sms', 'email', 'phone');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE channel;
    SQL
  end
end
