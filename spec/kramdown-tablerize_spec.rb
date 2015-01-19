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

  ['example-2'].each do |test_name|
    context test_name do
      reference_result = File.read "examples/#{test_name}.error.out"
      reference_result.gsub!(/\n?\.\*\n?/, '.*')

      it "should have the appropriate error output" do
        document = Kramdown::Document.new(
          File.read("examples/#{test_name}.md"), input: 'KramdownYamlTablerize'
        )
        expect { document.to_html }.to raise_error Regexp.new(reference_result, Regexp::MULTILINE)
      end
    end
  end
end
