#!/usr/bin/env python
from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket
from os import listdir
from os.path import isfile, join
import json
import pandas as pd

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
        
        elif self.data == 'History':
            self.sendAllDates()

        elif str(self.data)[-3:] == 'csv':
            pathName = "Game History/"
            pathName += str(self.data)
            print (pathName)
            df = pd.read_csv(pathName)
            csvData = df['Moves'].values.tolist()
            dataToSend = json.dumps(csvData)
            print(dataToSend)
            self.wss[-1].sendMessage(dataToSend)
            
        else:
            for ws in self.wss:
                ws.sendMessage(str(self.data))
        print(self.data)

    def sendAllDates(self):
        onlyfiles = [f for f in listdir("Game History") if isfile(join("Game History", f))]
        jsondata = {'history': onlyfiles}
        dataToSend = json.dumps(jsondata)
        self.wss[-1].sendMessage(dataToSend)

    def handleConnected(self):
        print(self.address, 'connected')
        if self not in self.wss:
            self.wss.append(self)

    def handleClose(self):
        print(self.address, 'closed')

server = SimpleWebSocketServer('localhost', 8765, SimpleEcho)
server.serveforever()