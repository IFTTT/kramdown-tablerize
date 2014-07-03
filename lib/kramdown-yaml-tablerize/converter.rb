require 'psych'
require 'yaml-tablerize'

module YamlTablerize
  # Prints out the 5 lines before and after the line where an error occurred.
  # This is useful for debugging embedded YAML, as the line number where the
  # error occurred in YAML won't be the same as where it occurred in the Markdown
  # source.
  def printable_error_context(el, e)
    line_number = 0
    el.value.lines
      .map { |line| "#{line_number += 1} #{line.chomp}" }[ [0, e.line - 5].max .. e.line + 5].join "\n"
  end
end

module Kramdown
  module Converter
    # kramdown's class for writing HTML. We monkey-patch this to include
    # a converter for :yaml_table.
    class Html
      # @return [String] an HTML fragment representing this element
      # @api private
      def convert_yaml_table(el, _indent)
        YamlTablerize.load(el.value).to_html
      rescue Psych::SyntaxError => e
        $stderr.puts "Tablerizer: YAML error for the following table:"
        $stderr.puts YamlTablerize.printable_error_context el, e
        $stderr.puts "backtrace:"
        raise e
      end
    end

    # kramdown's class for writing <arkdown. We monkey-patch this to include
    # a converter for :yaml_table that simply raises an error.
    class Kramdown
      def convert_yaml_table(_el, _opts)
        raise NotImplementedError
      end
    end

    # kramdown's class for writing LaTEX. We monkey-patch this to include
    # a converter for :yaml_table that simply raises an error.
    class Latex
      def convert_yaml_table(_el, _opts)
        raise NotImplementedError
      end
    end
  end
end
