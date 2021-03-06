# frozen_string_literal: true

module UiBibz::Ui::Core::Forms::Surrounds
  class SurroundCheckboxField < UiBibz::Ui::Core::Forms::Choices::CheckboxField
    # See UiBibz::Ui::Core::Dropdown.initialize

    private

    def component_html_options
      { label: false }
    end

    def component_wrapper_html_classes
      inline
    end

    def component_html_classes
      super << 'input-group-text'
    end
  end
end
