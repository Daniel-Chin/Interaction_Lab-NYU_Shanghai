import mouse
import keyboard
import sys
from threading import Lock
from time import sleep
from network import connect
import traceback

STRICT = False
PAGE = 4096

NOTE_ON_THRESHOLD = .01

dynamic = None
ableton = None

def main():
    global dynamic, ableton
    dynamic = Dynamic()
    dynamic.setup().acquire()
    ableton = Ableton()
    print('Start!')
    
    while True:
        print('Session start')
        s = connect()
        sleep(.2)
        dynamic.acquire()
        handle(s)
        dynamic.release()
        ableton.release()

class Dynamic:
    SENSITIVITY = .05
    SUSTAIN = .01   # I know, this should be per millis, but per packet works okay
    
    def __init__(self):
        self.x = None
        self.bottom = None
        self.top = None
        self.last_level = 0
    
    def setup(self):
        recorded_clicks = []
        lock = Lock()
        lock.acquire()
        def onClick(event):
            if isinstance(event, mouse.ButtonEvent) and event.event_type == 'up':
                x, y = mouse.get_position()
                recorded_clicks.append({'x': x, 'y': y})
                print(recorded_clicks[-1])
                if len(recorded_clicks) == 1:
                    print('Click at the top of the dynamic slider. ')
                else:
                    mouse.unhook_all()
                    self.x      = recorded_clicks[0]['x']
                    self.bottom = recorded_clicks[0]['y']
                    self.top    = recorded_clicks[1]['y']
                    lock.release()
        mouse.hook(onClick)
        print('Where is the dynamic slider? ')
        print('Click at the bottom of the dynamic slider. ')
        return lock
    
    def dragTo(self, level):
        if level < NOTE_ON_THRESHOLD or abs(level - self.last_level) > self.SENSITIVITY:
            level = max(level, self.last_level - self.SUSTAIN)
            self.last_level = level
            y = dynamic.top * (level) + dynamic.bottom * (1 - level)
            mouse.move(dynamic.x, y)
            if level < NOTE_ON_THRESHOLD:
                ableton.release()
            else:
                if ableton.held_down is None:
                    ableton.play(ableton.last_pitch)
    
    def acquire(self):
        mouse.move(dynamic.x, dynamic.bottom)
        mouse.press(mouse.LEFT)
        self.last_level = 0
    
    def release(self):
        mouse.release(mouse.LEFT)

class Ableton:
    KEY_MAP = 'asdfghj'
    def __init__(self):
        self.octave = 5
        self.held_down = None
        self.last_pitch = None
        self.last_pitch = 0
    
    def play(self, pitch):
        diff = pitch != self.last_pitch
        if diff:
            self.last_pitch = pitch
        if dynamic.last_level >= NOTE_ON_THRESHOLD:
            if diff or self.held_down is None:
                self.last_pitch = pitch
                self.release()
                octave = (pitch // 7) + 5
                self.setOctave(octave)
                key = self.KEY_MAP[pitch % 7]
                keyboard.press(key)
                self.held_down = key
    
    def setOctave(self, octave):
        delta = octave - self.octave
        todo = ['x'] * delta + ['z'] * - delta
        for i in todo:
            keyboard.press(i)
            sleep(.02)
            keyboard.release(i)
            sleep(.02)
        self.octave = octave
    
    def release(self):
        if self.held_down is not None:
            keyboard.release(self.held_down)
            self.held_down = None

def handle(s):
    try:
        buffer = b''
        while True:
            read = b''
            while b'\n' not in read:
                read = s.recv(PAGE)
                buffer += read
                if read == b'':
                    raise ConnectionResetError
            lines = buffer.split(b'\n')
            [handleLine(x.decode()) for x in lines[:-1]]
            buffer = lines[-1]
    except ConnectionResetError:
        print('Remote closed connection. ')

def handleLine(line):
    if not STRICT:
        line = line.replace('d', 'dynamic.dragTo').replace('p', 'ableton.play')
    # print(line)
    try:
        exec(line)
    except:
        traceback.print_exc()
        print('Problem line:', line)
        while True:
            sleep(5)
            print('Waiting for ^C...')

if __name__ == '__main__':
    main()
    sys.exit(0)
