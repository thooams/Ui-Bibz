require 'test_helper'

include UiBibz::Helpers
class UiHelperTest < ActionView::TestCase

  test 'breadcrumb' do
    actual = breadcrumb do |b|
      b.link 'Home', url: '#home', glyph: 'home'
      b.link 'Toto', { url: '#toto', status: :active }
    end
    expected = "<ol class=\"breadcrumb\"><li><a href=\"#home\"><i class=\"glyph fa fa-home\"></i> Home</a></li><li class=\"active\"><a href=\"#toto\">Toto</a></li></ol>"

    assert_equal expected, actual
  end

  test 'alert' do
    actual = notify 'toto'
    expected = "<div class=\"alert-info alert\" role=\"alert\">toto</div>"

    assert_equal expected, actual
  end

  test 'label' do
    actual   = label 'toto', state: :success, glyph: 'pencil'
    expected = "<span class=\"label-success label\"><i class=\"glyph fa fa-pencil\"></i> toto</span>"

    assert_equal expected, actual
  end

end
