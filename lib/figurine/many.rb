module Figurine
  module Many
    def many(model, options = {})
      @whitelist ||= {}
      @whitelist[model] = options[:only] || []

      define_method model do
        @attributes[model]
      end

      define_method "#{model}=" do |values|
        whitelist = self.class.instance_variable_get("@whitelist")[model]
        @attributes[model] = values.map do |val|
          if val.respond_to?(:to_hash)
            Hash[*val.to_hash.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
          elsif val.respond_to?(:attributes)
            Hash[*val.attributes.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
          end
        end
      end
    end
  end
end
