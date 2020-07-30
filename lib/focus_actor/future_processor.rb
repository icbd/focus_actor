require_relative 'cell_context'
require_relative 'future_cell'

module FocusActor
  class FutureProcessor
    attr_reader :instance

    def initialize(instance)
      @instance = instance
    end

    def method_missing(method, *args, &block)
      return super unless instance.respond_to?(method)

      queue = Queue.new
      Thread.new do
        queue.push instance.public_send(method, *args, &block)
      end

      FutureCell.new(queue)
    end

    def respond_to_missing?(method, include_all = false)
      instance.respond_to?(method) || super
    end
  end
end
