@ItemListMixin = ->
  @attributes
    tbody: 'table > tbody'
    empty: '.empty-row'
    item_collection = []

  @checkEmpty = (event, data) ->
    if @select('tbody').find('tr.order').length is 0
      @select('empty').fadeIn()
    else
      @select('empty').fadeOut()

  @handle_items = _.debounce(( (items) ->
    template = ''
    for item in Array.prototype.concat.apply([], items).reverse()
      template += JST["templates/order_active"](item)

    @select('tbody').prepend(template)
    @checkEmpty()
    item_collection = []
  ), 30)

  @addOrUpdateItem = (item) ->
    if item.origin_volume == item.volume
      item_collection.push(item)
      @handle_items(item_collection)
    else
      template = @getTemplate(item)
      existsItem = @select('tbody').find("tr[data-id=#{item.id}][data-kind=#{item.kind}]")

      if existsItem.length
        existsItem.html template.html()
      else
        template.prependTo(@select('tbody'))

      @checkEmpty()

  @removeItem = (id) ->
    item = @select('tbody').find("tr[data-id=#{id}]")
    item.hide 'slow', =>
      item.remove()
      @checkEmpty()

  @populate = (event, data) ->
    if not _.isEmpty(data.orders)
      @addOrUpdateItem item for item in data.orders

    @checkEmpty()

