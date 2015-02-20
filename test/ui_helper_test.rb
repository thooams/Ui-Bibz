require 'test_helper'

include UiBibz::Helpers
class UiHelperTest < ActionView::TestCase

  test 'complex panel' do
    panel cls: 'toto' do |pane|
      pane.header cls: 'header-class' do
        "Test header"
      end
      pane.body 'Test body', nil, cls: 'body-toto'
      pane.footer 'Test footer'
    end
  end

  test 'nav' do
    nav({cls: 'nav-momo'}) do
      tab "<a href='#'>toto</a>"
    end
  end

  test 'breadcrumb' do
    breadcrumb do
      "<li><a>Home</a></li>"
      "<li class='active'>Toto</li>"
    end
  end

  test 'list_group' do
    list_group do
      list 'toto'
      list 'momo', tag: :a, href: '#momo'
    end
  end

  test 'tab' do
    tab "<a href='#'>toto</a>", { active: true }, { class: 'tab'}
    tab "toto", active: true, selector: 'tab-en'
  end

  test 'complex grid' do
    create_list(:user, 25)
    params = {
      controller: 'users',
      action:     'index',
      sort:       'users.name_fr',
      direction:  'asc',
      per_page:   2,
      page:       1
    }
    users  = User.grid_search_pagination(params)

    grid store: users, cls: 'toto' do |pane|
      pane.header 'Test header'
      pane.body cls: 'ui' do
        'Test body'
      end
    end
  end

  test 'complex grid with custom actions' do
    create_list(:user, 25)
    params = {
      controller: 'users',
      action:     'index',
      sort:       'users.name_fr',
      direction:  'asc',
      per_page:   10,
      page:       1
    }
    users  = User.grid_search_pagination(params)

    grid store: users, cls: 'toto' do |pane|
      pane.header 'Test header'
      pane.body cls: 'ui' do
        'Test body'
      end
      pane.columns do |c|
        c.add({ name: '#', data_index: 'id' })
        c.add({ name: 'Name fr', data_index: 'name_fr', link: edit_user_path(:id), order: 2 })
        c.add({ name: 'Name en', data_index: 'name_en', order: 1 })
      end
      #pane.actions do
      #  link_to 'toto', users_path(:id)
      #  link_to 'momo', users_path(:id)
      #end
    end
  end

  test 'link button' do
    actual   = link_button 'Toto', users_path, type: 'danger', glyph: 'add'
    expected = "<a type=\"danger\" class=\"btn\" href=\"/users\"><i class=\"glyph fa fa-add fa-1x\"></i> Toto</a>"

    assert_equal expected, actual
  end

  test 'link action' do
    actual   = link_action 'Show', users_path, glyph: 'eye'
    expected = "<li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\"/users\"><i class=\"glyph fa fa-eye fa-1x fa-fw\"></i> Show</a></li>"

    assert_equal expected, actual
  end

end
