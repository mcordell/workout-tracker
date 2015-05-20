require 'trailblazer/autoloading'

Trailblazer::Operation::CRUD.module_eval do
  module Included
    def included(base)
      super
      base.send :include, Trailblazer::Operation::CRUD::ActiveModel
    end
  end
  extend Included # override CRUD::included.
end
