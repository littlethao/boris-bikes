require_relative 'bike'

class DockingStation
  attr_reader :bikes

  def initialize
    @bikes = []
  end

  def release_bike
    fail 'No bikes available' if self.empty?
    @bikes.pop
  end

  def dock(bike)
    fail "Docking station is full" if self.full?
  @bikes << bike
  end


  def full?
    if @bikes.length >= 20
      true
    end
  end

  def empty?
    if @bikes.empty?
      true
    end
  end
end
