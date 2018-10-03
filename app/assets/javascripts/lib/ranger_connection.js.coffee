stream = ['global',"#{gon.market.id}", 'order', 'trade']
query = {stream: stream}
address = "#{gon.ranger_host}:#{gon.ranger_port}?" + $.param(query, true)
barongPath = "#{gon.barong_domain}" + "/api/v1/sessions/jwt"
window.ranger = new RangerWebSocket address
if gon.user
  ranger.bind 'open', ->
    console.info 'Connection to Ranger has been established'
    $.ajax({
      type: "POST",
      url: barongPath,
      async: true,
      xhrFields: {
        withCredentials: true
      },
      success: (res) ->
        console.info 'Solving authorization challenge by sending JWT token'
        ranger.send JSON.stringify {jwt: "Bearer #{res}"}
    })
ranger.connect()
