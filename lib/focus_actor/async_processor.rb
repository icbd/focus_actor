require 'forwardable'
require_relative 'cell_context'

module FocusActor
  # This is a Proxy for instance.
  # It can response instance methods on instance.
  #
  # Start a new thread, and then loop to call methods in mailbox.
  class AsyncProcessor
    attr_reader :instance, :mailbox

    # mailbox should be thread safe
    def initialize(instance, mailbox: Queue.new)
      @instance = instance
      @mailbox = mailbox

      run!
    end

    # To call a method, push it to mailbox.
    def method_missing(method, *args, &block)
      return super unless instance.respond_to?(method)

      mailbox.push CellContext.new(method, args, block)
      nil
    end

    def respond_to_missing?(method, include_all = false)
      instance.respond_to?(method) || super
    end

    private

    def run!
      Thread.new do
        loop do
          cell_context = mailbox.pop
          instance.public_send(cell_context.method, *cell_context.args, &cell_context.block)
        end
      end
    end
  end
end
