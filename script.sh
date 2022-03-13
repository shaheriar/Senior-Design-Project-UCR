export DISPLAY=:0
unclutter -idle 0.001 -root &
python3.8 server.py &
python3.8 servergame.py &
cd chessboard/build/web
npx serve &
sleep 0.5
chromium-browser -kiosk -no-default-browser-check http://localhost:3000
pkill -P $$