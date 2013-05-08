require 'spec_helper'

describe 'Figurine::One' do
  class CarForm < Figurine::Form
    one :trunk
    one :engine, :only => [:horsepower, :torque]
  end

  describe '#new' do
    it 'allows a one collaborator to be set via a hash' do
      car_form = CarForm.new(:trunk => { :foo => 'bar', :baz => 'qux' })
      expect(car_form.trunk).to eql(:foo => 'bar', :baz => 'qux')
    end


    it 'allows a one collaborator to be set via an object responding to #attributes' do
      trunk = Trunk.new(:foo => 'bar', :baz => 'qux')     
      car_form = CarForm.new(:trunk => trunk)
      expect(car_form.trunk).to eql(:foo => 'bar', :baz => 'qux')
    end
  end

  describe 'accessors' do
    it 'creates an accessor for setting the one collaborator via an object responding to #attributes' do
      trunk = Trunk.new(:foo => 'bar', :baz => 'qux')     
      car_form = CarForm.new
      car_form.trunk = trunk
      expect(car_form.trunk).to eql(:foo => 'bar', :baz => 'qux')
    end

    it 'creates an accessor for setting the one collaborator via a hash' do
      car_form = CarForm.new
      car_form.trunk = { :foo => 'bar', :baz => 'qux' }
      expect(car_form.trunk).to eql(:foo => 'bar', :baz => 'qux')
    end
  end

  describe 'assigning non-attribute values' do
    it 'allows the assignment of non-attribute values if accessor is defined' do
      class CarForm
        attr_accessor :something
      end
      something = mock :something
      car_form = CarForm.new(:trunk => { :foo => 'bar', :baz => 'qux' }, :something => something)
      expect(car_form.something).to eql(something)
    end

    it 'raises undefined method error if accessor is not defined' do
      class CarForm
        undef :something
        undef :something=
      end
      something = mock :something
      expect { CarForm.new(:trunk => { :foo => 'bar', :baz => 'qux' }, :something => something) }.to raise_error(NoMethodError)
    end
  end

  describe 'whitelisting attrs' do
    it 'only sets attrs for the specified atts' do
      engine = Engine.new({ :horsepower => 800, :torque => 700, :cylinders => 16 })
      car_form = CarForm.new(:engine => engine)
      expect(car_form.engine).to eql(:horsepower => 800, :torque => 700)
    end
  end
end
