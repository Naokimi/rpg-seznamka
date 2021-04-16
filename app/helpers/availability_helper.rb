module AvailabilityHelper
  def availability_to_rows(availability)
    # e.g.: Mo [0,1,2], Tu [0,1,2] => [[1,1,0,0,0,0,0], [1,1,0,0,0,0,0], [1,1,0,0,0,0,0], [0,0,0,0,0,0,0]...]
    availability.values.map { |slots| (0..23).to_a.map { |hour| slots.include?(hour) ? 1 : 0 } }.transpose
  end
end
