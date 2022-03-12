python3.8 server.py &
python3.8 servergame.py &
cd chessboard/build/web
npx serve &
chromium-browser -kiosk -no-default-browser-check http://localhost:3000