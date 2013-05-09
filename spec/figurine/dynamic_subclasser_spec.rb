require 'spec_helper'

describe Figurine::DynamicSubclasser do
  describe '.create' do
    it 'returns a new subclass of the given constant, with the given name' do
      subclass = Figurine::DynamicSubclasser.create(Figurine::Collaborator, "Special")
      subclass.name.should include('Figurine::Collaborator::Special')
    end
  end
end
