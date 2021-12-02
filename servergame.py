#!/usr/bin/env python
import asyncio
import websockets
import Chess

async def gme(uri):
    async with websockets.connect(uri,ping_interval=None) as websocket:
        print('IN GAME')
        game = Chess.chessGame()
        gameMode = await game.menu(websocket)
        await game.start(gameMode, websocket) 

asyncio.get_event_loop().run_until_complete(gme('ws://localhost:8765'))
print('SERVER STARTED')