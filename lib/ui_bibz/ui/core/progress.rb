module UiBibz::Ui::Core

  # Create a progress bar
  #
  # This element is an extend of UiBibz::Ui::Core::Component.
  #
  # ==== Attributes
  #
  # * +content+ - Content of element
  # * +options+ - Options of element
  # * +html_options+ - Html Options of element
  #
  # ==== Options
  #
  # You can add HTML attributes using the +html_options+.
  # You can pass arguments in options attribute:
  # * +state+ - State of élement with symbol value:
  #   (+:secondary+, +:primary+, +:info+, +:warning+, +:danger+)
  # * +max+ - Max value (default: 100)
  # * +value+ - Value of percentage (default: content)
  # * +animated+ - Boolean
  # * +striped+ - Boolean
  #
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Progress.new(percentage, options = nil, html_options = nil)
  #
  #   UiBibz::Ui::Core::Progress.new(options = nil, html_options = nil) do
  #     percentage
  #   end
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::Progress.new(50%, { value: 50})
  #   # or
  #   UiBibz::Ui::Core::Progress.new(10%, { value: 10, state: :success },{ class: 'test' }).render
  #   # or
  #   UiBibz::Ui::Core::Progress.new({ value: 10, state: :success},{ class: 'test' }) do
  #     10%
  #   end.render
  #
  # ==== Helper
  #
  #   progress(integer, options = {}, html_options = {})
  #
  #   progress(options = { tap: true }, html_options = {}) do |pb|
  #     pb.bar(integer, options = {}, html_options = {})
  #     pb.bar(options = {}, html_options = {}) do
  #       integer
  #     end
  #   end
  #
  class Progress < Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
      @bars = []
    end

    # Render html tag
    def render
      content_tag :progress, @content, class_and_html_options(['progress', striped, animated]).merge({ max: max, value: value })
    end

  private

    def striped
      'progress-striped' unless @options[:striped].nil?
    end

    def animated
      'progress-animated' unless @options[:animated].nil?
    end

    def max
      @options[:max] || 100
    end

    def value
      @options[:value] || @content.to_i
    end

    def state
      "progress-#{ @options[:state] }" unless @options[:state].nil?
    end

  end
end