module Hashable
  def initialize(attrs)
    @attrs = attrs
  end

  def attributes
    @attrs
  end
end

class Trunk
  include Hashable
end

class Engine
  include Hashable
end
