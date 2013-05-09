require 'spec_helper'

describe Figurine::DynamicSubclasser do
  describe '.create' do
    it 'returns a new subclass of the given constant, with the given name' do
      subclass = Figurine::DynamicSubclasser.create(Figurine::Attributes, "Special")
      subclass.name.should include('Figurine::Attributes::Special')
    end
  end
end
