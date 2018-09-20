stream = ['global',"#{gon.market.id}", 'order', 'trade']
query = {stream: stream}
address = "#{gon.ranger_host}:#{gon.ranger_port}?" + $.param(query, true)
barongPath = "#{gon.barong_domain}" + "/api/v1/sessions/jwt"
window.ranger = new RangerWebSocket address
ranger.bind 'open', ->
  getCookie = (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0

    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null
  console.info 'Connection to Ranger has been established'
  return if not gon.user
  console.info 'Solving authorization challenge by sending JWT token'
  ranger.send JSON.stringify {jwt: "Bearer #{getCookie("jwt_token")}"}
ranger.bind 'error', ->
  alert("Sorry, couldn't establish connection with WebSocket API. If problem persists, please contact support.")
