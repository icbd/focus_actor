require_relative '../lib/focus_actor/async'
require_relative '../lib/focus_actor/future'

class User
  include FocusActor::Async
  include FocusActor::Future

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

CASE_TIMES = 5
COST_TIME = 0.01 # second
