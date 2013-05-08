module Figurine
  module One

    def one(model, attributes = {})
      @whitelist ||= {}
      @whitelist[model] = attributes[:only] || []

      define_method model do
        @attributes[model]
      end

      define_method "#{model}=" do |val|
        whitelist = self.class.instance_variable_get("@whitelist")[model]
        @attributes[model] = if val.respond_to?(:to_hash)
          Hash[*val.to_hash.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
        elsif val.respond_to?(:attributes)
          Hash[*val.attributes.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
        end
      end
    end

  end
end
