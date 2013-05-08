require 'figurine'

describe 'Figurine::One' do
  class FakeFigurine < Figurine::Form
    one :thing
    one :other_thing, :only => [:first_name, :last_name]
  end

  class Thing
    def initialize(attrs)
      @attrs = attrs
    end

    def attributes
      @attrs
    end
  end

  class OtherThing < Thing; end

  describe '#new' do
    it 'allows a one collaborator to be set via a hash' do
      figurine = FakeFigurine.new(:thing => { :foo => 'bar', :baz => 'qux' })
      expect(figurine.thing).to eql(:foo => 'bar', :baz => 'qux')
    end


    it 'allows a one collaborator to be set via an object responding to #attributes' do
      thing = Thing.new(:foo => 'bar', :baz => 'qux')     
      figurine = FakeFigurine.new(:thing => thing)
      expect(figurine.thing).to eql(:foo => 'bar', :baz => 'qux')
    end
  end

  describe 'accessors' do
    it 'creates an accessor for setting the one collaborator via an object responding to #attributes' do
      thing = Thing.new(:foo => 'bar', :baz => 'qux')     
      figurine = FakeFigurine.new
      figurine.thing = thing
      expect(figurine.thing).to eql(:foo => 'bar', :baz => 'qux')
    end

    it 'creates an accessor for setting the one collaborator via a hash' do
      figurine = FakeFigurine.new
      figurine.thing = { :foo => 'bar', :baz => 'qux' }
      expect(figurine.thing).to eql(:foo => 'bar', :baz => 'qux')
    end
  end

  describe 'assigning non-attribute values' do
    it 'allows the assignment of non-attribute values if accessor is defined' do
      class FakeFigurine
        attr_accessor :something
      end
      something = mock :something
      figurine = FakeFigurine.new(:thing => { :foo => 'bar', :baz => 'qux' }, :something => something)
      expect(figurine.something).to eql(something)
    end

    it 'raises undefined method error if accessor is not defined' do
      class FakeFigurine
        undef :something
        undef :something=
      end
      something = mock :something
      expect { FakeFigurine.new(:thing => { :foo => 'bar', :baz => 'qux' }, :something => something) }.to raise_error(NoMethodError)
    end
  end

  describe 'whitelisting attrs' do
    it 'only sets attrs for the specified atts' do
      other_thing = OtherThing.new({ :first_name => 'bob', :last_name => 'loblaw', :age => 42 })
      figurine = FakeFigurine.new(:other_thing => other_thing)
      expect(figurine.other_thing).to eql(:first_name => 'bob', :last_name => 'loblaw')
    end
  end
end
