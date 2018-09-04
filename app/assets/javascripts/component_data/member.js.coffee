@MemberData = flight.component ->
  @after 'initialize', ->
    return if not gon.user

    @attr.ranger.bind 'account', (data) =>
      gon.accounts[data.currency.code] = data
      @trigger 'account::update', gon.accounts

    @attr.ranger.bind 'order', (data) =>
      @trigger "order::#{data.state}", data

    @attr.ranger.bind 'trade', (data) =>
      @trigger 'trade', data

    # Initializing at bootstrap
    @trigger 'account::update', gon.accounts
    @trigger 'order::wait::populate', orders: gon.my_orders if gon.my_orders
    @trigger 'trade::populate', trades: gon.my_trades if gon.my_trades
