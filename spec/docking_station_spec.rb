require 'docking_station'
require 'bike'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  it 'checks for that a default capacity is assigned when creating a new instance' do
    expect(subject.capacity).to eq(DockingStation::DEFAULT_CAPACITY)
  end

  it 'checks for that a specified capacity is assigned when creating a new instance' do
    station = DockingStation.new 25
    expect(station.instance_variable_get(:@capacity)).to eq(25)
  end

  it 'releases working bikes' do
      subject.dock Bike.new
      bike = subject.release_bike
      expect(bike).to be_working
  end

  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error 'No bikes available'
    end

    it 'raises an error when bike is broken' do
      bike = Bike.new
      bike.report_broken
      subject.dock(bike)
      expect { subject.release_bike }.to raise_error "This bike is broken"
    end
  end

  describe '#dock(bike)' do
    it 'docks something' do
      bike = Bike.new
      expect(subject.dock(bike)).to eq [bike]
    end

    it 'raises an error when docking station is full' do
      subject.capacity.times { subject.dock(Bike.new) }
      expect { subject.dock(Bike.new)}.to raise_error 'Docking station is full'
    end
  end
end
