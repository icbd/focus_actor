require_relative '../lib/focus_actor/async'

class User
  include FocusActor::Async

  attr_reader :name, :age

  def initialize(name)
    @name = name
    @age = 0
  end

  def grow(cost = 0.1)
    sleep cost
    @age += 1
  end
end
