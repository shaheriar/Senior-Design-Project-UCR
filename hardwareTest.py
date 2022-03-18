from hardware import *

# Logic for capturing:

# # up
# # down

# # could send both moves and it woould ignore the invalid one?

# # up (whos turn matters?)
# # up (ignore)
# # down


# LIGHTS UP EVERY SQUARE WITH A PIECE ON IT GREEN
def all_leds_green():
    try:
        prev = getBoard()
        current = []
        while(True):
            LEDS = []
            # setGPIO(51)  #for testing voltage
            current = getBoard()
            for i in range(64):
                if current[i] == 1:
                        LEDS.append((squareMap[i], GREEN))
                        # print(LEDS)
                        # print()
            setLEDS(LEDS)
    except:
        pass
    GPIO.cleanup()


# RAVE 
# ################# SHIFT REGISTER EXAMPLE #####################
def led_rave_test():
    try:
      while(True):
        for color in [RED, GREEN, BLUE]:
          LEDs = []
          for letter in "abcdefgh":
            for i in range(1, 9):
              print((letter + str(i), color))
              # setLEDS([(letter + str(i), color)])
              LEDs.append((letter + str(i), color))
              # time.sleep(0.05)
          setLEDS(LEDs)
          #time.sleep(0.05)
      # while(True):
      #   pass
    except:
      pass
    #PINs final cleaning
    GPIO.cleanup()


# LIGHTS EVERY LED UP 1 AT A TIME
################# SHIFT REGISTER EXAMPLE #####################
def snake_led_rgb():
  try:
    while(True):
      for color in [RED, GREEN, BLUE]:
        for letter in "abcdefgh":
          for i in range(1, 9):
            print((letter + str(i), color))
            setLEDS([(letter + str(i), color)])
            time.sleep(0.1)
  # while(True):
  #   pass
  except:
    pass
  #PINs final cleaning
  GPIO.cleanup()

def ripple():
  #ripple effect with LEDs
  #start with center 4 squares
  #then move to the next

  LEDS = []
  for i in range(4):
    LEDS.append((squareMap[i], BLUE))
  setLEDS(LEDS)
  time.sleep(0.01)
  while(True):  
    for i in range(4, 64):
      LEDS.append((squareMap[i], BLUE))
      LEDS.pop(0)
      setLEDS(LEDS)
      time.sleep(0.01)



def test_func():
  arr = ["a2a4", "a2a3", "b2b4", "b2b3", "c2c4", "c2c3", "d2d4", "d2d3", "e2e4", "e2e3", "f2f4", "f2f3", "g2g4", "g2g3", "h2h4", "h2h3", "b1a3", "b1c3", "g1f3", "g1h3"]
  print(get_move(arr))

    #led_rave_test()
    #all_leds_green()

# test_func()
all_leds_green()
# snake_led_rgb()
#led_rave_test()
# ripple()