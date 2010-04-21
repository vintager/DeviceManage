class CreatePinPads < ActiveRecord::Migration
  #  密码键盘	password_pad
  #接口	interface
  #语音	voice
  #防窥罩 anti_peep_cover

  def self.up
    create_table :pin_pads do |t|
      t.string  "interface"
      t.string  "voice"
      t.string  "anti_peep_cover"
      t.text     "memo"

      t.timestamps
    end
  end

  def self.down
    drop_table :pin_pads
  end
end
