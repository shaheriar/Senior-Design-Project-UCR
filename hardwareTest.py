from hardware import *

# Logic for capturing:

# # up
# # down

# # could send both moves and it woould ignore the invalid one?

# # up (whos turn matters?)
# # up (ignore)
# # down



# ## LIGHTS UP SQUARE GREEN WHEN A PIECE IS PLACED 
# # LIGHTS UP RED WHEN REMOVED
# # ONLY WORKS WITH 1 SQUARE
# # ################# GET MOVE EXAMPLE #####################
# try:
# 	prev = getBoard()
# 	current = []
# 	while(True):
# 		# setGPIO(51)  #for testing voltage
# 		current = getBoard()
# 		for i in range(64):
# 			if current[i] != prev[i]:
# 				if current[i] == 0:
# 					setLEDS([(squareMap[i], RED)])
# 				if current[i] == 1:
# 					setLEDS([(squareMap[i], GREEN)])
# 		prev = current
# except:
# 	pass
# GPIO.cleanup()



# LIGHTS UP EVERY SQUARE WITH A PIECE ON IT GREEN
# try:
# 	prev = getBoard()
# 	current = []
# 	while(True):
# 		LEDS = []
# 		# setGPIO(51)  #for testing voltage
# 		current = getBoard()
# 		for i in range(64):
# 			if current[i] == 1:
# 					LEDS.append((squareMap[i], GREEN))
# 					# print(LEDS)
# 					# print()
# 		setLEDS(LEDS)
# except:
# 	pass
# GPIO.cleanup()




# # RAVE 
# # ################# SHIFT REGISTER EXAMPLE #####################
# try:
#   while(True):
#     for color in [RED, GREEN, BLUE]:
#       LEDs = []
#       for letter in "abcdefgh":
#         for i in range(1, 9):
#           print((letter + str(i), color))
#           # setLEDS([(letter + str(i), color)])
#           LEDs.append((letter + str(i), color))
#           # time.sleep(0.05)
#       setLEDS(LEDs)
#       time.sleep(0.05)
#   # while(True):
#   #   pass
# except:
#   pass
# #PINs final cleaning
# GPIO.cleanup()



# # LIGHTS EVERY LED UP 1 AT A TIME
# ################# SHIFT REGISTER EXAMPLE #####################
# try:
#   while(True):
#     for color in [RED, GREEN, BLUE]:
#       for letter in "abcdefgh":
#         for i in range(1, 9):
#           print((letter + str(i), color))
#           setLEDS([(letter + str(i), color)])
#           time.sleep(0.01)
#   # while(True):
#   #   pass
# except:
#   pass
# #PINs final cleaning
# GPIO.cleanup()
