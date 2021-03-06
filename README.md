# FocusActor

This is a toy tool to extend concurrency for objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'focus_actor'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install focus_actor

## Usage

```ruby
require 'focus_actor'

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

user = User.new('Bob')
user.async.grow(1) # return nil, without block
future = user.future.grow(1) # return FutureCell
future.value
```
