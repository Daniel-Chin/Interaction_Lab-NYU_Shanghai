Instructor: <b>Marcele</b>  
Recitation partner: <b>Linhui</b>  

This is a write up for Interaction Lab SP18 [Recitation on Sensors](https://wp.nyu.edu/shanghai-ima-interaction-lab/recitation-3-sensors/) on Mar 1, 2019.  
## Joystick controlling buzzer  
The X input of the joystick controls the pitch, and the Y input controls how fast it beeps.  

Our code:  
<code>tone(10, x + 220, y);</code>  
<code>delay(y + 100);</code>  

We referenced [Analog Joystick](https://www.brainy-bits.com/arduino-joystick-tutorial/) and [tone](https://www.arduino.cc/reference/en/language/functions/advanced-io/tone/) for help.  

Our interaction with it:  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/PitchStick.mp4"][/video]  

The schematic:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/scheme.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/scheme.png" alt="scheme of circuit" /></a>  

## Questions and my answers
#### What did you intend to assemble in the recitation exercise? If your sensor/actuator combination were to be used for pragmatic purposes, who would use it, why would they use it, and how could it be used?

I intended to try something I never tried before in the recitation. First, we decided to use the vibration sensor. Fascinated by it, I looked up how it worked. It was mind-widening. Then, we went for the joystick, since neither of us worked with one before. Soon we got readings from the joystick. Lastly, we tried to decide what output to use. Because joystick provides 2-dimensional input, we chose the buzzer, intending to make a Theremin-like instrument. Then we discovered that <code>tone()</code> cannot control the volume it plays, so we implemented periodic beeping.  

If your sensor/actuator combination were to be used for pragmatic purposes, the first image popping into my head is a weak patient using it to express their needs. They may be too weak to speak, and the traditional bell button only accepts yes/no input, so this little circuit could help.  

#### Code is often compared to following a recipe or tutorial.  Why do you think that is?

Because the CPU faithfully executes whatever we code it to.  

We prepare the "recipe" for the CPU. 

#### In <i>Language of New Media</i>, Manovich describes the influence of computers on new media. In what ways do you believe the computer influences our human behaviors?

Computer changes how we create data and how we find data.  

I remember the time when Microsoft Word was not as powerful, and I would write down math formulas on paper and scan them into my Word document. However, now, I just alt + 3 to insert new formula and build my formula in Word. Notice how my feelings changed. Back in the days, I would feel frustrated to do formulas in Word, and writing formulas on paper felt much easier. On the contrary, now if I have a Word document open, I feel too lazy to grab any paper. Generally speaking, the process of how people create data is slowly migrating from the material world to the computer world.  

The same applies to how we find data. With the Internet and all the search engines available, we do not need to go to the library as often. My family love to debate on questions, including but not limited to Physics, Philosophy, Health, Life Living, etc. When we encounter something we feel uncertain about, we would inquire on the Internet. The tools we used upgraded from Baidu to Google, and to Google Scholar.  

Computer really changes our behaviors throughout the years.  
