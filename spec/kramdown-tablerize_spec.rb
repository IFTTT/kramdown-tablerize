require 'spec_helper'

describe Tablerize do
  ['example-1'].each do |test_name|
    context test_name do
      reference_result = File.read "examples/#{test_name}.html"

      it "should be correctly converted" do
        test_result = Kramdown::Document.new(
          File.read("examples/#{test_name}.md"), input: 'KramdownYamlTablerize'
        ).to_html
        expect(test_result.chomp).to eq(reference_result.chomp)
      end
    end
  end
end
