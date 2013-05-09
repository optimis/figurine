require 'spec_helper'

class CarForm < Figurine::Form
  many :seats, :only => [:material, :color]
  many :tires
end

describe 'Figurine::Many' do
  context 'many collaborator does not have whitelist' do
    it 'allows many collaborators to be set via a collection of objects that respond to attributes' do
      tires = [Tire.new(:wear_rating => 'QR'), Tire.new(:wear_rating => 'ZR')]
      car_form = CarForm.new(:tires => tires)
      expect(car_form.tires).to eql([{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
    end

    it 'allows many collaborators to be set via a collection of hashes' do
      car_form = CarForm.new(:tires => [{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
      expect(car_form.tires).to eql([{:wear_rating => 'QR'}, {:wear_rating => 'ZR'}])
    end

    it 'ignores nil values' do
      car_form = CarForm.new(:tires => nil)
      expect(car_form.tires).to be_empty
    end

    it 'ignores nil values within the array' do
      car_form = CarForm.new(:tires => [nil, {:wear_rating => 'ZR'}])
      expect(car_form.tires).to eql([{:wear_rating => 'ZR'}])
    end
  end

  context 'many collaborators have whitelist' do
    context 'id passed' do
      it 'allows many collaborators to be set with a whitelist of attributes from objects' do
        seats = [
          Seat.new(:material => 'Leather', :color => 'Black', :piping => 'Red', :id => 1),
          Seat.new(:material => 'Cloth', :color => 'Brown', :piping => 'White', :id => 2)
        ]
        car_form = CarForm.new(:seats => seats)
        expect(car_form.seats).to eql([
          {:material => 'Leather', :color => 'Black', :id => 1},
          {:material => 'Cloth', :color => 'Brown', :id => 2}
        ])
      end

      it 'allows many collaborators to be set with a whitelist of attributes from hashes' do
        seats = [
          { :material => 'Leather', :color => 'Black', :piping => 'Red', :id => 1 },
          { :material => 'Cloth', :color => 'Brown', :piping => 'White', :id => 2 }
        ]
        car_form = CarForm.new(:seats => seats)
        expect(car_form.seats).to eql([
          {:material => 'Leather', :color => 'Black', :id => 1},
          {:material => 'Cloth', :color => 'Brown', :id => 2}
        ])
      end

      it 'allows many collaborators to be set with a whitelist of attributes from a mixed collection' do
        seats = [
          Seat.new(:material => 'Leather', :color => 'Black', :piping => 'Red', :id => 1),
          { :material => 'Cloth', :color => 'Brown', :piping => 'White', :id => 2 }
        ]
        car_form = CarForm.new(:seats => seats)
        expect(car_form.seats).to eql([
          {:material => 'Leather', :color => 'Black', :id => 1},
          {:material => 'Cloth', :color => 'Brown', :id => 2}
        ])
      end
    end

    context 'no id provided' do
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
  end
end
