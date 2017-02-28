(($) ->

  updateOptionsHtml = (data, componentTarget) ->
    data.forEach (opt) ->
      console.log opt
      componentTarget.append($("<option></option>").attr("value", opt.value).text(opt.text))

  updateMultiColumnHtml = (data, componentTarget) ->
    componentTarget.multiSelect('removeAllOptions')
    updateOptionsHtml(data, componentTarget)
    componentTarget.multiSelect('refresh')

  updateTargetComponent = (target, data, componentTarget) ->
    switch target.component
      when "select"             then updateOptionsHtml(data, componentTarget)
      when "multi_column_field" then updateMultiColumnHtml(data, componentTarget)

  afterActionMultiColumn = (that, mode, target, componentTarget)->
    me = that
    that.qs1.cache() if @qs1?
    that.qs2.cache() if @qs2?

    if mode == "remote"
      $.ajax({ url: target.url, data: { ids: that.options.values } }).done (data) ->
        updateTargetComponent(target, data, componentTarget)

    if mode == "local"
      data = target.data || []
      data = data.filter (value) ->
        return me.options.values.includes(String(value.connect_option_id))

      updateTargetComponent(target, data, componentTarget)

  $.fn.inputConnected = (options) ->

    defaults =
      mode:        "remote"
      events:      "change"  # change, click, ...
      target:
        url:        null     # url for remote connection
        selector:   null     # component target id
        data: []             # data for local connection
        component:  "select" # type of component
        # Add a proxy
        # Proxy:
        #  url:    null
        #  method: 'GET'
        #  data:   null

    settings = $.extend({}, defaults, options)

    self = this
    return this.each ->
      connect = $(this).data().connect
      connect.target = connect.target || {}
      return unless connect?

      mode        = connect.mode   || settings.mode
      events      = connect.events || settings.events
      target      =
        url:       connect.target.url       || settings.target.url
        data:      connect.target.data      || settings.target.data
        selector:  connect.target.selector  || settings.target.selector
        component: connect.target.component || settings.target.component

      componentTarget = $("#{ target.selector }")


      console.log mode

      if target.component == "multi_column_field"
        $(this).multiSelect
          values: []
          afterSelect: (values) ->
            @options.values.push values[0]
            afterActionMultiColumn(this, mode, target, componentTarget)

          afterDeselect: (values) ->
            @options.values.splice($.inArray(values[0], @options.values), 1)
            afterActionMultiColumn(this, mode, target, componentTarget)

      if $(this).hasClass("select-field")
        $(this).on events, (e) ->
          e.preventDefault()
          componentTarget.empty()

          if mode == "remote"
            $.ajax({ url: target.url }).done (data) ->
              updateTargetComponent(target, data, componentTarget)

          if mode == "local"
            data               = target.data || settings.target.data
            connect_option_id  = $(this).children("option:selected").val()
            data               = data.filter (value) ->
              return Number(value.connect_option_id) == Number(connect_option_id)

            updateTargetComponent(target, data, componentTarget)

)(jQuery)