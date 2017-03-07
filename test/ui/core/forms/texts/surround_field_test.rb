require 'test_helper'
include UiBibz::Helpers

class SurroundFieldTest < ActionView::TestCase

    test 'surround_field without prepend and append' do
      actual = UiBibz::Ui::Core::Forms::Texts::SurroundField.new('test').render
      expected = "<input type=\"text\" name=\"test\" id=\"test\" class=\"form-control\" />"

      assert_equal expected, actual
    end

    test 'surround_field with prepend and append' do
      actual = UiBibz::Ui::Core::Forms::Texts::SurroundField.new('test', append: '1', prepend: '2').render
      expected = "<div class=\"input-group\"><span class=\"input-group-addon\">1</span><input type=\"text\" name=\"test\" id=\"test\" class=\"form-control\" /><span class=\"input-group-addon\">2</span></div>"

      assert_equal expected, actual
    end

    test 'surround_field size' do
      actual = UiBibz::Ui::Core::Forms::Texts::SurroundField.new('test', size: :xs, append: '1', prepend: '2').render
      expected = "<div class=\"input-group input-group-xs\"><span class=\"input-group-addon\">1</span><input type=\"text\" name=\"test\" id=\"test\" class=\"form-control\" /><span class=\"input-group-addon\">2</span></div>"

      assert_equal expected, actual
    end
end                                             
