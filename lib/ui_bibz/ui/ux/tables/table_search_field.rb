require "ui_bibz/ui/ux/tables/components/store"
module UiBibz::Ui::Ux::Tables

  class TableSearchField < UiBibz::Ui::Core::Component

    # Initialize search_field with component item
    def initialize content = nil, options = nil, html_options = nil
      html_options = options
      options = content
      content = nil
      super
    end

    # Render html tag
    def render
      if options[:wrap_form] != false
        form_tag(url_for(url_parameters), method: :get, class: 'form-table-search-field') do
          search_field_html_in_wrap
        end
      else
        search_field_html
      end
    end

  private

    def url_parameters
      #{ controller: store.controller, action: store.action, id: store.param_id }
      store.parameters
    end

    # Store must be generated by *table_search_pagination* method
    def store
      @store ||= if @options[:store].nil?
        raise 'Store is nil!'
      elsif @options[:store].try(:records).nil?
        raise 'Store can be created only with "table_search_pagination" method!'
      else
        Store.new @options.delete :store
      end
    end

    def search_field_html
      # add surround_field maybe ?
      content_tag :div, html_options do
        concat content_tag(:span, UiBibz::Ui::Core::Glyph.new('search').render, class: 'input-group-addon')
        concat tag(:input, type: 'search', value: store.search, name: 'search', class: 'form-control', placeholder: search_placeholder_field)
        concat content_tag(:span, UiBibz::Ui::Core::Glyph.new('times-circle').render, class: 'clear-search-btn input-group-addon')
      end
    end

    def search_field_html_in_wrap
      content_tag :div, html_options do
        concat content_tag(:span, UiBibz::Ui::Core::Glyph.new('search').render, class: 'input-group-addon')
        store.parameters.each do |k,v|
          concat tag(:input, type: 'hidden', name: k, value: v) unless default_parameters?(k)
        end
        concat tag(:input, type: 'hidden', name: 'store_id', value: store.id) unless store.id.nil? # if there is more one table in html page
        concat tag(:input, type: 'search', value: store.search, name: 'search', class: 'form-control', placeholder: search_placeholder_field)
        concat content_tag(:span, clear_button, class: 'input-group-btn')
      end
    end

    def clear_button
      content_tag :button, UiBibz::Ui::Core::Glyph.new('times-circle').render, type: :button, class: 'btn btn-secondary'
    end

    def component_html_classes
      %w(input-group input-group-sm table-search-field)
    end

    def search_placeholder_field
      UiBibz::Utils::Internationalization.new('ui_bibz.grid.searchable.field.placeholder', searchable_attributes: searchable_attributes_sentence).translate
    end

    def searchable_attributes_sentence
      store.searchable_attributes.map do |i|
        attribute_name = underscorize_hash(i)
        UiBibz::Utils::Internationalization.new("ui_bibz.grid.searchable.field.searchable_attributes.#{ model_name }.#{ attribute_name }", default: [translate_searchable_attributes_by_active_record(attribute_name), attribute_name.to_s.humanize]).translate
      end.to_sentence(locale: I18n.locale)
    end

    def model_name
      store.model.to_s.underscore
    end

    def translate_searchable_attributes_by_active_record attr
      store.model.human_attribute_name(attr)
    end

    def underscorize_hash attr
      attr.kind_of?(Hash) ? "#{ attr.keys.first }_#{ attr.values.first }".to_sym : attr
    end

    def default_parameters?(k)
      %w(store_id search controller action utf8).include?(k)
    end

  end
end