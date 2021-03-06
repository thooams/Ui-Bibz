# frozen_string_literal: true

module UiBibzInputs
  class UiDropdownSelectFieldInput < CollectionInput
    def input(_wrapper_options)
      UiBibz::Ui::Core::Forms::Selects::DropdownSelectField.new(input_attribute_name, new_options, input_html_options).render
    end
  end
end
