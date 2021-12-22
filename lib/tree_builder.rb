# frozen_string_literal: true

require_relative 'node'

class TreeBuilder
  DEFAULT_STRUCT_CONFIG = {
    struct_level_tabulator: '  ',
    struct_nodes_separator: "\n"
  }.freeze

  DEFAULT_NODE_CONFIG = {
    node_class: Node,
    node_initial_method: :new,
    node_value_set_method: 'val=',
    node_children_get_method: :children,
    node_child_add_method: :<<
  }.freeze

  CONFIG = DEFAULT_STRUCT_CONFIG.merge(DEFAULT_NODE_CONFIG)
    
  class << self
    def call(struct, **config)
      config = CONFIG.merge(config)

      tree = {}

      struct.split(config[:struct_nodes_separator]).each do |node_string|
        level = node_string.scan(config[:struct_level_tabulator]).length
        value = node_string.gsub(config[:struct_level_tabulator], '')
        @root_level ||= level

        node = config[:node_class].send(config[:node_initial_method])
        node.send(config[:node_value_set_method], value)
        tree[level] = node

        parent_node = tree[level - 1]
        parent_node&.send(config[:node_children_get_method])&.send(config[:node_child_add_method], node)
      end

      tree[@root_level]
    end
  end
end
