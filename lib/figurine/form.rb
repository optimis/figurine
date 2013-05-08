module Figurine
  class Form
    extend One
    extend Many

    def initialize(attributes= {})
      @attributes = {} 

      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
