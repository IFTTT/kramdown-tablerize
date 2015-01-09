require 'tablerize'

module Tablerize
  module Plugin
    module Kramdown
      ERROR_CONTEXT_LINES = 5

      # Prints out the 5 lines before and after the line where an error
      # occurred. This is useful for debugging embedded YAML, as the line
      # number where the error occurred in YAML won't be the same as where it
      # occurred in the Markdown source.
      def self.printable_error_context(text, target_line)
        raw_lines = text.lines
        start_line = [target_line - ERROR_CONTEXT_LINES, 0].max
        end_line   = [target_line + ERROR_CONTEXT_LINES, lines.length - 1].min
        fmt_lines = [start_line..end_line].map do |line|
          "#{line} #{raw_lines[line].chomp}"
        end
        fmt_lines.join("\n")
      end

      def self.convert_yaml_tablerize_to_html(yaml_tablerize)
        Tablerize.load(yaml_tablerize).to_html + "\n"
      rescue Psych::SyntaxError => e
        e.message.prepend [
          "Tablerize YAML error for the following table:",
          printable_error_context(el, e),
          "backtrace:"
        ].join('\n')
        raise e
      end
    end
  end
end
