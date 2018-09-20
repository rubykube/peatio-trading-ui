stream = ['global',"#{gon.market.id}", 'order', 'trade']
query = {stream: stream}
address = "#{gon.ranger_host}:#{gon.ranger_port}?" + $.param(query, true)
barongPath = "#{gon.barong_domain}" + "/api/v1/sessions/jwt"
window.ranger = new RangerWebSocket address
$.ajax({
  type: "POST",
  url: barongPath,
  async: true,
  xhrFields: {
    withCredentials: true
  },
  success: (res) ->
    ranger.bind 'open', ->
      console.info 'Connection to Ranger has been established'
      return if not gon.user
      console.info 'Solving authorization challenge by sending JWT token'
      ranger.send JSON.stringify {jwt: "Bearer #{res}"}
    ranger.bind 'error', ->
      alert("Sorry, couldn't establish connection with WebSocket API. If problem persists, please contact support.")
})
