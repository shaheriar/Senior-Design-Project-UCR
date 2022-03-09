from hardware import *

# # up
# # down


# # could send both moves and it woould ignore the invalid one?

# # up (whos turn matters?)
# # up (ignore)
# # down

# ################# GET MOVE EXAMPLE #####################
# try:
# 	prev = getBoard()
# 	current = []
# 	while(True):
# 		# setGPIO(51)  #for testing voltage
# 		current = getBoard()
# 		for i in range(64):
# 			if current[i] != prev[i]:
# 				if current[i] == 0:
# 					print(squareMap[i], "up")
# 				if current[i] == 1:
# 					print(squareMap[i], "down")
# 		prev = current
# except:
# 	pass
# GPIO.cleanup()





# ################# SHIFT REGISTER EXAMPLE #####################
try:
  LEDS = [("a1", RED),("h7", GREEN)]
  setLEDS(LEDS)
  while(True):
    pass
except:
  pass
#PINs final cleaning
GPIO.cleanup()
