DEFAULT_PORT = 'COM12'
WAV_FILENAME = ['p1.wav', 'p2.wav']

from serial import Serial, SerialException #, serial_for_url
import sys
import glob
import simpleaudio
from console import console
from threading import Thread

player_who = {'value': 1}

def main():
    port = choosePort()
    serial = Serial(port = port)
    myThread().start()
    handle(serial)

def serialPorts(max = 256): # Modified based on Thomas's answer to https://stackoverflow.com/questions/12090503/listing-available-com-ports-with-python
    """ Lists serial port names

        :raises EnvironmentError:
            On unsupported or unknown platforms
        :returns:
            A list of the serial ports available on the system
    """
    if sys.platform.startswith('win'):
        ports = ['COM%s' % (i + 1) for i in range(max)]
    elif sys.platform.startswith('linux') or sys.platform.startswith('cygwin'):
        # this excludes your current terminal "/dev/tty"
        ports = glob.glob('/dev/tty[A-Za-z]*')
    elif sys.platform.startswith('darwin'):
        ports = glob.glob('/dev/tty.*')
    else:
        raise EnvironmentError('Unsupported platform')
    
    result = []
    for port in ports:
        try:
            s = Serial(port)
            s.close()
            result.append(port)
        except (OSError, SerialException):
            pass
    return result

def choosePort():
    ports = serialPorts(max = 24)
    print('Available ports:')
    if not [print(x) for x in ports]:
        print('(empty)')
    print('Plase paste the name, ')
    if DEFAULT_PORT in ports:
        print('Or hit ENTER to use default (%s).' % DEFAULT_PORT)
    op = input('here >')
    if op.strip() == '':
        if DEFAULT_PORT in ports:
            return DEFAULT_PORT
        else:
            print('Default port "%s" not available.' % DEFAULT_PORT)
            sys.exit(1)
    else:
        return op

def playAudio(filename):
    simpleaudio.WaveObject.from_wave_read(simpleaudio.wave.open(filename)).play()

class myThread(Thread):
    def run(self):
        console(globals())

def handle(serial):
    while True:
        buffer = []
        while True:
            buffer.append(serial.read(1).decode())
            print(buffer[-1], end = '')
            if buffer[-1] == '\n':
                print('', end = '', flush = True)
                if buffer[0] == '!':
                    command = ''.join(buffer[1:]).strip()
                    if command.startswith('reset'):
                        pass
                    elif command == 'win':
                        playAudio(WAV_FILENAME[2 - player_who['value']])
                    elif command == 'lose':
                        playAudio(WAV_FILENAME[player_who['value'] - 1])
                    else:
                        print('Error: invalid command,', command)
                        # assert False
                break

def togglePlayer():
    player_who['value'] = 3 - player_who['value']

if __name__ == '__main__':
    main()
