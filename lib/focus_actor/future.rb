require_relative 'future_processor'

module FocusActor
  module Future
    module InitializeExtension
      def initialize(*args, &block)
        super
        @future = FutureProcessor.new(self)
      end
    end

    def self.included(base)
      base.send :prepend, InitializeExtension
      base.attr_reader :future
    end
  end
end
