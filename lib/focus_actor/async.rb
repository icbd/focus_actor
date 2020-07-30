require_relative 'async_processor'

module FocusActor
  module Async
    module InitializeExtension
      def initialize(*args, &block)
        super
        @async = AsyncProcessor.new(self)
      end
    end

    def self.included(base)
      base.send :prepend, InitializeExtension
      base.attr_reader :async
    end
  end
end
