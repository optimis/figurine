require 'figurine'

class CarForm < Figurine::Form
  many :seats, :only => [:material, :color]
  many :tires
end

describe 'Figurine::Many' do
  it 'allows many collaborators to be set via a collection of objects that respond to attributes' do
    tires = [Tire.new(:wear_rating => 'QR'), Tire.new(:wear_rating => 'ZR')]
    car_form = CarForm.new(:tires => tires)
    expect(car_form.tires).to eql([{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
  end

  it 'allows many collaborators to be set via a collection of hashes' do
    car_form = CarForm.new(:tires => [{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
    expect(car_form.tires).to eql([{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
  end

  it 'allows many collaborators to be set with a whitelist of attributes from objects' do
    seats = [
      Seat.new(:material => 'Leather', :color => 'Black', :piping => 'Red'),
      Seat.new(:material => 'Cloth', :color => 'Brown', :piping => 'White')
    ]
    car_form = CarForm.new(:seats => seats)
    expect(car_form.seats).to eql([{:material => 'Leather', :color => 'Black'}, {:material => 'Cloth', :color => 'Brown'}])
  end

  it 'allows many collaborators to be set with a whitelist of attributes from hashes' do
    seats = [
      { :material => 'Leather', :color => 'Black', :piping => 'Red' },
      { :material => 'Cloth', :color => 'Brown', :piping => 'White' }
    ]
    car_form = CarForm.new(:seats => seats)
    expect(car_form.seats).to eql([{:material => 'Leather', :color => 'Black'}, {:material => 'Cloth', :color => 'Brown'}])
  end

  it 'allows many collaborators to be set with a whitelist of attributes from a mixed collection' do
    seats = [
      Seat.new(:material => 'Leather', :color => 'Black', :piping => 'Red'),
      { :material => 'Cloth', :color => 'Brown', :piping => 'White' }
    ]
    car_form = CarForm.new(:seats => seats)
    expect(car_form.seats).to eql([{:material => 'Leather', :color => 'Black'}, {:material => 'Cloth', :color => 'Brown'}])
  end
end
