module UiBibz::Ui
  class Panel < Ui

    attr_accessor :table

    def initialize options = nil, html_options = nil
      @options      = options || {}
      @html_options = html_options || {}
    end

    def header content = nil, options = nil, html_options = nil, &block
      @header = Component.new content, options, html_options, &block
    end

    def body content = nil, options = nil, html_options = nil, &block
      @body = Component.new content, options, html_options, &block
    end

    def footer content = nil, options = nil, html_options = nil, &block
      @footer = Component.new content, options, html_options, &block
    end

    def render
      content_tag(:div, class: cls("panel panel-default")) do
        concat(header_html) unless @header.nil?
        concat(body_html)   unless @body.nil?
        concat(footer_html) unless @footer.nil?
      end
    end

  protected

    def cls klass
      [@html_options.delete(:class), @options.delete(:class), klass].compact.join(' ')
    end

  private

    def header_html
      content_tag(:div, @header.render, { class: @header.cls("panel-heading") }.merge(@header.html_options)) unless @header.nil?
    end

    def body_html
      content_tag :div, @body.render, { class: @body.cls("panel-body"), role: 'tabpanel' }.merge(@body.html_options)
    end

    def footer_html
      content_tag :div, @footer.render, { class: @footer.cls("panel-footer"), role: 'tabpanel' }.merge(@footer.html_options) unless @header.nil?
    end

  end
end
