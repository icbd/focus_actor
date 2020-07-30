module FocusActor
  class FutureCell
    def initialize(queue)
      @queue = queue
      @value_lock = Mutex.new
    end

    def value
      @value ||= @value_lock.synchronize do
        @value ||= @queue.pop
      end
    end
  end
end
