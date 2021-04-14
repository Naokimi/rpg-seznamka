class AddDefaultAvailabilityValue < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :availability, :jsonb, default: {monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: []}
    change_column :groups, :session_times, :jsonb, default: {monday: [], tuesday: [], wednesday: [], thursday: [], friday: [], saturday: [], sunday: []}
  end
end
