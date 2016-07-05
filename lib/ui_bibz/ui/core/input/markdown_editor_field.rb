module UiBibz::Ui::Core

  # Create a MarkdownEditorField
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
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::MarkdownEditorField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::MarkdownEditorField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::MarkdownEditorField.new('search', prepend: 'Prepend content', append: 'Append content', class: 'test')
  #
  #   UiBibz::Ui::Core::MarkdownEditorField.new(prepend: glyph('pencil'), append: glyph('camera-retro')) do
  #     #content
  #   end
  #
  # ==== Helper
  #
  #   markdown_editor_field(options = {}, html_options = {}) do
  #    # content
  #   end
  #
  class MarkdownEditorField < Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def render
      text_area_input_tag 'toto'
    end

    private

    # Simple_form or not
    def text_area_input_tag
      if options[:builder].nil?
        text_area_tag content, html_options[:value], html_options
      else
        options[:builder].text_area content, html_options
      end
    end

    def component_html_classes
      'form-control'
    end

    # :lg, :sm or :xs
    def size
      "input-group-#{ options[:size] }" if options[:size]
    end

    def status
      "has-#{ options[:status] }" if options[:status]
    end

    def component_html_options
      options[:state] == :disabled ? { disabled: 'disabled' } : {}
    end

  end
end
