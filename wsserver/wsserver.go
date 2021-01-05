package wsserver

import ("net/http"
		"time"
		"github.com/gorilla/websocket"
)

var (
	upgrade = websocket.Upgrader{
		CheckOrigin:func(r *http.Request) bool {
			return true
		},
	}
)

func wsHandler(w http.ResponseWriter, r *http.Request) {
	var (
		conn *websocket.Conn
		err error
		data []byte
		msgType int
	)
	if conn, err = upgrade.Upgrade(w,r,nil);err != nil {
		return
	}

	go func() {
		var (
			err error 
		)
		for{
			if err = conn.WriteMessage(websocket.TextMessage,[]byte("heartbeat"));err != nil {
				return 
			}
			time.Sleep(1 * time.Second)
		}
	}()

	for {
		if msgType,data,err = conn.ReadMessage();err != nil {
			goto ERR
		}
		if err = conn.WriteMessage(msgType,data);err != nil {
			goto ERR
		}
	}
ERR:
	conn.Close()
}

/*
Server 启动websocket服务端
*/
func Server() {
	http.HandleFunc("/ws",wsHandler)
	http.ListenAndServe("0.0.0.0:7777",nil)
}