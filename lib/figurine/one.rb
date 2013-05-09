module Figurine
  module One

    def one(model, attributes = {})
      @whitelist ||= {}
      @whitelist[model] = attributes[:only] || []

      define_method model do
        @attributes[model]
      end

      define_method "#{model}=" do |val|
        return if val.nil?
        whitelist = self.class.instance_variable_get("@whitelist")[model]
        @attributes[model] = DynamicSubclasser.create(Collaborator, model.to_s.classify).new(model, val, whitelist)
      end
    end

  end
end
