require 'will_paginate'
require "will_paginate-bootstrap"
module UiBibz::Ui
  class Paginable < Ui
    include WillPaginate::ActionView

    def initialize store, options
      @store   = store
      @options = options
    end

    def render
      content_tag :div do
        concat pagination_html
        concat per_page_html
        concat tag(:br, class: 'clear')
      end
    end

    def paginable?
      @options[:paginable].nil? ? true : @options[:paginable]
    end

  private

    def pagination_html
      will_paginate(@store.records, params: { controller: @store.controller },  renderer: BootstrapPagination::Rails)
    end

    def per_page_html
      content_tag :div, class: 'per-page' do
        concat "Per page: "
        concat select_tag('per_page', options_for_select([25, 50, 100], @store.per_page), class: 'form-control')
      end
    end

  end
end