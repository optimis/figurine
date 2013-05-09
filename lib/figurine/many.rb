module Figurine
  module Many
    def many(model, options = {})
      @whitelist ||= {}
      @whitelist[model] = options[:only] || []

      define_method model do
        @attributes[model]
      end

      define_method "#{model}=" do |values|
        @attributes[model] = if values.nil?
           []
        else
          whitelist = self.class.instance_variable_get("@whitelist")[model]
          values.compact.map do |val|
            DynamicSubclasser.create(Collaborator, model.to_s.classify).new(val, whitelist)
          end
        end
      end
    end
  end
end
