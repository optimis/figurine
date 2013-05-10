require 'active_support/core_ext/hash/slice'

module Figurine
  class Collaborator < ActiveSupport::BasicObject
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    def initialize(given, whitelist)
      @given = given
      attributes = if given.respond_to?(:to_hash)
        given.to_hash
      elsif given.respond_to?(:attributes)
        given.attributes
      end
      attributes = attributes.slice(*whitelist) unless whitelist.empty?
      @attributes = (given[:id] ? attributes.merge!(:id => given[:id]) : attributes)
      @attributes.each do |name, val|
        self.class.send(:define_method, name) do
          attributes[name]
        end
        
        self.class.send(:define_method, "#{name}=") do |val|
          attributes[name] = val
        end
      end
    end

    def object
      @given
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
