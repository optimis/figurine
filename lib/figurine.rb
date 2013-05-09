require 'active_model'

require 'figurine/version'

module Figurine
  autoload :Attributes,        'figurine/attributes'
  autoload :DynamicSubclasser, 'figurine/dynamic_subclasser'
  autoload :Form,              'figurine/form'
  autoload :Many,              'figurine/many'
  autoload :One,               'figurine/one'
end
