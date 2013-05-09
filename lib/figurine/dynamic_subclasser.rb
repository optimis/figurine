module Figurine
  module DynamicSubclasser

    def self.create(klass, name)
      collaborator = Class.new(klass)
      collaborator.instance_eval do
        @name = name
        
        define_method :class do
          collaborator
        end

        def self.model_name
          ActiveModel::Name.new(self, nil, name)
        end
      end
      klass.const_set("#{name}_#{collaborator.hash}", collaborator)
    end
  end
end
