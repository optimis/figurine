require 'spec_helper'

describe Figurine::Collaborator do
  describe '#method_missing' do
    it 'proxies for @attributes' do
      {}.methods.each do |method|
        expect(Figurine::Collaborator.new({}, [])).to respond_to(method)
      end
    end

    it 'calls the method on ActiveSupport::BasicObject if @attributes does not respond to method' do
      expect { Figurine::Collaborator.new({}, []).foo }.to raise_error NoMethodError
    end
  end

  describe '#==' do
    it 'returns true if passed val is equal to @attributes' do
      expect(Figurine::Collaborator.new({ :foo => 'bar' }, []) == { :foo => 'bar' }).to be_true
    end

    it 'returns false if passed val does not equal to @attributes' do
      expect(Figurine::Collaborator.new({ :foo => 'bar' }, []) == { :baz => 'qux' }).to be_false
    end
  end

  describe 'dynamic accessors' do
    it 'defines dynamic accessors for the keys in @attributes' do
      attributes = { :foo => 'bar', :baz => 'qux' }
      attributes.each do |key, value|
        expect(Figurine::Collaborator.new(attributes, []).send(key)).to eql(value)
      end
    end
  end
end
