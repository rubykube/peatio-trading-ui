var RangerWebSocket = function(url){
    var callbacks = {};

    var conn;

    this.connect = function(){
        conn = new WebSocket(url);

        // dispatch to the right handlers
        conn.onmessage = function(evt){
            var json = JSON.parse(evt.data)
            if (json instanceof Array) {
                dispatch(json[0], json[1])
            } else {
                if (json['success']) {
                    console.log(json['success']['message'])
                } else {
                    notifier.notify(gon.i18n.notification.title, json['error']['message'])
                    alert(json['error']['message'])
                }
            }
        };

        conn.onerror = function(){dispatch('error',null)}
        conn.onclose = function(){dispatch('close',null)}
        conn.onopen = function(){dispatch('open',null)}
    }

    this.bind = function(event_name, callback){
        callbacks[event_name] = callbacks[event_name] || [];
        callbacks[event_name].push(callback);
        return this;// chainable
    };

    this.send = function(payload){
        conn.send( payload ); // <= send JSON data to socket server
        return this;
    };


    var dispatch = function(event_name, message){
        var chain = callbacks[event_name];
        if(typeof chain == 'undefined') return; // no callbacks for this event
        for(var i = 0; i < chain.length; i++){
            chain[i]( message )
        }
    }
};