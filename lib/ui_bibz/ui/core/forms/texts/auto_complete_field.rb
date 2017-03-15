module UiBibz::Ui::Core::Forms::Texts

  # Create a AutoCompleteField
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
  # * option_tags - Array, Object [required]
  #
  # ==== Signatures
  #
  #   UiBibz::Ui::Core::Forms::Texts::AutoCompleteField.new(content, options = {}, html_options = {}).render
  #
  #   UiBibz::Ui::Core::Forms::Texts::AutoCompleteField.new(options = {}, html_options = {}) do
  #     content
  #   end.render
  #
  # ==== Examples
  #
  #   options = options_for_select(2.times.map{ |i| "option #{i}" })
  #   UiBibz::Ui::Core::Forms::Texts::AutoCompleteField.new('company', { option_tags: options }, { class: 'test' })
  #
  #   options = options_for_select(2.times.map{ |i| "option #{i}" })
  #   UiBibz::Ui::Core::Forms::Texts::AutoCompleteField.new(option_tags: options) do
  #     #content
  #   end
  #
  # ==== Helper
  #
  #   autocomplete_field(options = {}, html_options = {}) do
  #    # content
  #   end
  #
  class AutoCompleteField < UiBibz::Ui::Core::ConnectedComponent

    # See UiBibz::Ui::Core::Component.initialize
    def initialize content = nil, options = nil, html_options = nil, &block
      super
    end

    # Render html tag
    def render
      if options[:refresh]
        refresh_render
      else
        text_field_input_tag  + data_list_render
      end
    end

    private

    def refresh_render
      content_tag :div, class: 'input-group field-refresh' do
        concat text_field_input_tag
        concat data_list_render
        concat refresh_btn_html
      end
    end

    def component_html_data
      connect_options
    end

    def data_list_render
      content_tag :datalist, options[:option_tags], id: data_list_name
    end

    def text_field_input_tag
      text_field_tag content, html_options[:value], html_options
    end

    def component_html_options
      args = { autocomplete: true, list: data_list_name }
      args = args.merge(options[:state] == :disabled ? { disabled: 'disabled' } : {})
      args
    end

    def connect_opts
      selector = options[:refresh][:target][:selector]
      options[:refresh][:target][:selector] = selector.blank? ? "##{ data_list_name }" : selector
      options[:refresh]
    end

    def component_html_classes
      'form-control'
    end

    def data_list_name
      @datalist ||= "#{ html_options[:id] || content.to_s.parameterize.underscore }-datalist"
    end

    def status
      "form-control-#{ options[:status] }" if options[:status]
    end

  end
end