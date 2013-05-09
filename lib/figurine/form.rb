module Figurine
  class Form
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    extend One
    extend Many

    def initialize(attributes= {})
      @attributes = {} 

      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def persisted?
      false
    end
  end
end
