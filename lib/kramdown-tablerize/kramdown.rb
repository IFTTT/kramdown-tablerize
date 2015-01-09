require_relative 'tablerize'

require 'kramdown'

module Kramdown
  # Register :yaml_tablerize as a block-level element
  # @private
  class Element
    # Register :yaml_tablerize as a block-level element
    CATEGORY[:yaml_tablerize] = :block
  end

  module Converter
    class Html
      # Convert :yaml_tablerize -> HTML
      # @api private
      def convert_yaml_tablerize(el, _indent)
        Tablerize::Plugin::Kramdown.convert_yaml_tablerize_to_html(el.value)
      end
    end

    class Kramdown
      # Convert :yaml_tablerize -> Markdown (not implemented)
      def convert_yaml_tablerize(_el, _opts)
        raise NotImplementedError
      end
    end

    class Latex
      # Convert :yaml_tablerize -> LaTEX (not implemented)
      def convert_yaml_tablerize(_el, _opts)
        raise NotImplementedError
      end
    end
  end

  module Parser
    class KramdownYamlTablerize < ::Kramdown::Parser::Kramdown
      YAML_TABLE_PATTERN = /^#{OPT_SPACE}---[ \t]*table[ \t]*---(.*?)---[ \t]*\/table[ \t]*---/m

      def initialize(source, options)
        super
        @block_parsers.unshift(:yaml_tablerize)
      end

      # Convert Markdown -> :yaml_tablerize
      # @api private
      def parse_yaml_tablerize
        @src.pos += @src.matched_size
        @tree.children << Element.new(:yaml_tablerize, @src[1])
      end

      define_parser(:yaml_tablerize, YAML_TABLE_PATTERN)
    end
  end
end
