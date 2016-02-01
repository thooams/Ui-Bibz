module UiBibz::Ui::Core

  # Create a multiSelect
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
  # * searchable - Boolean
  # * selectable_opt_group - Boolean
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::MultiColumnField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::MultiColumnField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   UiBibz::Ui::Core::MultiColumnField.new({num: 2, offset: 1, size: 3}, class: 'test') do
  #     #content
  #   end
  #
  #   UiBibz::Ui::Core::MultiColumnField.new([{num: 2, offset: 1, size: 3}, { num: 3}], class: 'test') do
  #     #content
  #   end
  #
  # ==== Helper
  #
  #   multi_column_field(options = {}, html_options = {}) do
  #    # content
  #   end
  #
  class MultiColumnField < Component

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
      searchable
      selectable_opt_group
      @html_options = class_and_html_options('multi-column').merge({ multiple: true })
    end

    # Render html tag
    def render
      select_tag @content, @options[:option_tags], @html_options
    end

    private

    def searchable
      @html_options = @html_options.merge({ "data-searchable" => true }) if @options[:searchable]
    end

    def selectable_opt_group
      @html_options = @html_options.merge!({ "data-selectable-optgroup" => true }) if @options[:selectable_optgroup]
    end

  end
end