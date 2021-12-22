# frozen_string_literal: true

require_relative 'lib/tree_builder'

struct = <<-STR
42
  15
  8
  -9
    17
    -5
    14
STR

root = TreeBuilder.call(struct)

puts 'each'
root.each { |node| print("#{node.val} ") }
# 42 15 8 -9 17 -5 14

puts
puts

struct = <<-STR
42
..15
..8
..-9
....17
....-5
....14
STR

root = TreeBuilder.call(struct, struct_level_tabulator: '..')

puts 'each2'
root.each2 { |node| print("#{node.val} ") }
# 42 15 8 -9 17 -5 14

puts
