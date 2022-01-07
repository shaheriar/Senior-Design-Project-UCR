#!/usr/bin/env python
from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket
import time

class SimpleEcho(WebSocket):
    wss = [] # Should be globally scoped

    # def countdown(self, t):    
    #     while t:
    #         mins, secs = divmod(t, 60)
    #         timer = '{:02d}:{:02d}'.format(mins, secs)
    #         print(timer, end="\r")
    #         time.sleep(1)
    #         t -= 1

    def handleMessage(self):
        if self.data is None:
            self.data = ''
        
        if self.data == 'History':
            self.wss[-1].sendMessage(str('Requesting History'))
        else:
            for ws in self.wss:
                ws.sendMessage(str(self.data))
        print(self.data)

    def handleConnected(self):
        print(self.address, 'connected')
        if self not in self.wss:
            self.wss.append(self)

    def handleClose(self):
        print(self.address, 'closed')

server = SimpleWebSocketServer('localhost', 8765, SimpleEcho)
server.serveforever()