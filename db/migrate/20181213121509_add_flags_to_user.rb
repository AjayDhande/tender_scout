class AddFlagsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :flags, :string, array: :true, default: []
    User.reset_column_information
    User.all.each do |u|
      unless u.free?
        u.flags << "verified"
        u.save
      end
    end
  end
end
