class FixMoneyDecimalRound < ActiveRecord::Migration
  def self.up
    # This doesn't work:
    #change_column('jobs','price', 'decimal', :default => 0, :precision => 8, :scale => 2)

    # So we do it the hard way:
    execute "ALTER TABLE `jobs` CHANGE `price` `price` DECIMAL( 8, 2 ) NULL DEFAULT '0'"
    execute "ALTER TABLE `invoices` CHANGE `amount` `amount` DECIMAL( 8, 2 ) NULL DEFAULT '0'"
    execute "ALTER TABLE `payments` CHANGE `amount` `amount` DECIMAL( 8, 2 ) NULL DEFAULT '0'"
  end

  def self.down
  end
end
