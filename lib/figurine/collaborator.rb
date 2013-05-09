module Figurine
  class Collaborator < ActiveSupport::BasicObject
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def initialize(model, val, whitelist)
      @model = model
      attributes = if val.respond_to?(:to_hash)
        Hash[*val.to_hash.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
      elsif val.respond_to?(:attributes)
        Hash[*val.attributes.select { |key, _| whitelist.include?(key) || whitelist.empty? }.flatten]
      end
      @attributes = attributes = val[:id] ? attributes.merge!(:id => val[:id]) : attributes
      @attributes.each do |name, val|
        self.class.define_method name do
          attributes[name]
        end
        
        self.class.define_method "#{name}=" do |val|
          attributes[name] = val
        end
      end
    end

    def method_missing(m, *args, &block)
      if @attributes.respond_to?(m)
        @attributes.send(m, *args, &block)
      else
        super
      end
    end

    def ==(other)
      @attributes == other
    end
    alias :eql? :==
  end
end
