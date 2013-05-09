require 'active_model'

require 'figurine/version'

module Figurine
  autoload :Collaborator,      'figurine/collaborator'
  autoload :DynamicSubclasser, 'figurine/dynamic_subclasser'
  autoload :Form,              'figurine/form'
  autoload :Many,              'figurine/many'
  autoload :One,               'figurine/one'
end
