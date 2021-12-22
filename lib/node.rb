# frozen_string_literal: true

require_relative 'logger'

class Node
  include Logger

  attr_accessor :val, :children

  def initialize
    @children = []
  end

  # for more readable use different name method on children (array)
  Array.alias_method :array_each, :each

  # recursion
  # each is called on initial object only in recursion
  def each(passed_object = self, &block)
    block.call(passed_object)

    log('self id', object_id)

    passed_object.children&.array_each { |child_object| each(child_object, &block) }
  end

  # recursion
  # each2 is called on every object in recursion
  def each2(&block)
    block.call(self)

    log('self id', object_id)

    children&.array_each { |child_object| child_object.each2(&block) }
  end
end
