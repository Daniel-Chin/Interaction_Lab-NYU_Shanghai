Instructor: Marcela  
Group Partner: [Tristan](https://wp.nyu.edu/shanghai-ima-documentation/wp-admin/edit.php?post_type=post&author=41309)

Here you will learn about <b>Simplinstrument</b>, our group's final project for [Interaction Lab SP19](https://wp.nyu.edu/shanghai-ima-interaction-lab/) .  

You control the electronic musical instrument by moving your hand while blowing into a mouthpiece.  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/tristan.mp4"][/video]  

## Design 
Music instruments are difficult.  

Piano is difficult.  
Flute is difficult.  
Saxophone is difficult.  
French horn is difficult.  
Violin is difficult.  

However, whistle is easy.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/download.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/download.jpg" alt="a coach whistle" /></a>  
The harder you blow, the louder it will sound. Simple and intuitive.  

In the same way, you control the [Dynamics level](https://vi-control.net/community/threads/the-difference-between-dynamics-cc-1-and-expression-cc-11.58127/) (loudness) of <b>Simplinstrument</b> by blowing in to a mouthpiece.  
<a href="https://media.giphy.com/media/Q60pnFP9oZ5o3ULRM5/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/Q60pnFP9oZ5o3ULRM5/giphy.gif" alt="A box enclosing BMP085" /></a>  
In the mouthpiece is an air pressure sensor, [BMP085](https://www.adafruit.com/product/391). The harder you blow, the higher the air pressure in the mouthpiece will be.  

You control the pitch by rotating you hand up and down. The ring on your finger contains a gyroscope, [MPU6050](https://www.invensense.com/products/motion-tracking/6-axis/mpu-6050/). It senses the angular acceleration of your finger to calculate the absolute orientation of your hand.  

<b>Simplinstrument</b> is meant for musicians and [non-musicians](https://www.google.com/search?q=normal+people). The goal is for musicians to find it usable and expressive, and for non-musicians to play music without any training.  

## Scaffolding Mode
<b>Simplinstrument</b> offer two modes: Expert Mode and Scaffolding Mode.  

In <b>Expert Mode</b>, you have access to all white keys ([diatonic](https://www.youtube.com/watch?v=8InrO9Vzhfk)).  
We tried making all keys available (chromatic), but that turned <b>Simplinstrument</b> into a difficult instrument. So we removed the black keys.  
Only providing the [pentatonic scale](https://www.youtube.com/watch?v=8InrO9Vzhfk), however, is not "expert" enough for Expert Mode.  
So we settled with all white keys.  

<b>Scaffolding Mode</b> is especially nice.  
A background music plays, whose chord progression is [Am-F-C-G](https://www.youtube.com/watch?v=Wc4FV3dL3sQ). You have access to all pitches within the chord that's currently playing in the background. In other words, no matter what you do, you always make harmonies.  

The Scaffolding Mode turned out to sound way better than we envisioned. Random hand movements created melodies that sounded highly professional.  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/tristan.mp4"][/video]  

## User Feedbacks
### "Make sure the texture of the sound is beautiful"
Indeed! Texture matters. We chose a synthesizer from [Spitfire Audio Labs](https://www.spitfireaudio.com/labs/). It's free; but it's awesome.  

### "Which way does this ring go onto my finger?"
Good question. It matters because otherwise the gyroscope would give flipped readings. We cleared the confusion by adding a Ring Platform.  
<a href="https://media.giphy.com/media/QAgOr5guif0rAw87rX/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/QAgOr5guif0rAw87rX/giphy.gif" alt="hand take ring off from the platform" /></a>  

### "Remove the visual interface"
At first we had a visual interface to help musicians pinpoint their hand orientation to their desired pitch. It didn't quite work out.  
<a href="https://media.giphy.com/media/WRL1fZgxohLz0KklH4/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/WRL1fZgxohLz0KklH4/giphy.gif" alt="Sheldon playing the instrument" /></a>  

Marcela suggested we remove the visual and blindfold the player. That's exactly what we did.  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/daniel.mp4"][/video]  

### "My hand can't bend that low"
We changed the finger orientation input range from (-.5, .3) to (-.3, .3)  

### "Why not have multi player symphony?" 
That can be achieved by making two copies of <b>Simplinstrument</b>.  

### "Allow other body parts to also control the music"
This is actually what I really want to have in the project. It is only not implemented because of time constrain.  

### "Add a tutorial"
No. We should keep things <b>simple</b> and let the player explorer on their own.  

## Problems and how we solved them
### MPU6050 didn't work! 
We asked Nick. Nick told us to solder the PINs. It worked.  
I guess one does not simply plug jumper cables into breakout board PINs.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/391-00.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/391-00.jpg" alt="Photo of breakout board with PINs" /></a>  

### The gyroscope outputs angular acceleration, but we need absolute orientation! 
I tried to write an algorithm to integrate the acceleration into orientation. A lot of Linear Algebra:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/math_0.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/math_0.jpg" alt="Draft paper with math" /></a>  

And I wrote this code: [Github link](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/gyro_math/gyro_math.ino)  

It worked!  
<a href="https://media.giphy.com/media/RJVL1P6tKTwAQ4CXR0/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/RJVL1P6tKTwAQ4CXR0/giphy.gif" alt="Processing showing a motion tracking 3D model" /></a>  
I optimized the code for performance. In the end, one loop on Arduino Uno takes 2 milliseconds.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/profiling.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/profiling.jpg" alt="code snippet of profiling" /></a>  

However, any sudden movement of the gyroscope would make the algorithm accumulate error. Damn... The time step was still too large.  
Looks like we had to rely on the <i>DMP</i>!!!  

<i>DMP</i> refers to the Digital Motion Processor mounted on MPU6050. DMP does fast calculations and outputs the absolute orientation of the chip. Now you ask: "Isn't that exactly what you need? Why do all the Linear Algebra yourself when you can use DMP?" To answer that, let me quote [Arduino Playground](https://playground.arduino.cc/Main/MPU-6050/): "For this DMP, InvenSense has a discouragement policy, by not supplying enough information how to program the DMP. However, some have used reverse engineering to capture firmware."  
That is pretty scary! The last thing a programmer wants is the lack of documentation. This is why DMP was my last resort.  

However, <b>simplinstrument</b> needs a robust input. So I tried working with DMP. Fortunately, [Electronic Cats](https://github.com/ElectronicCats) wrote a very helpful [library](https://github.com/ElectronicCats/mpu6050). It worked the first time I tried. The DMP handles sudden movements pretty perfectly.  

The output of DMP is in [Quaternion](https://www.youtube.com/watch?v=d4EgbgTm0Bg). I tried to learn it, but it was too much. I ended up eyeball the four scalers and simply decided to use `quat.y`.  

### Every now and then, <i>NaN</i> takes over! 
This was a fun one.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/isinan.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/isinan.jpg" alt="code snippet of NaN checking" /></a>  
It took me a long time to fix, because I assumed there was a 0/0. After thorough debugging, the problem became clear:  

acos(1.0000000001) = NaN!  

My mind was blown. I marveled over the difference between doing Math on CPU and doing math on paper.  

Once known, the problem was easy to fix - A call to [constrain(x, 0, 1)](https://www.arduino.cc/reference/en/language/functions/math/constrain/).  

## Technical details that are fun to read
### Plot my exhale
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/blow_plot.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/blow_plot.jpg" alt="Serial plotter shows readings" /></a>  
Air pressure connected to Arduino serial plotter  

### 826 and 1608 are 300 Pa apart
The air pressure sensor seemed to frequently require recalibrating... We thought we bought a trashy sensor, until we suddenly realized that the Studio and the dorm room are 8 floors different in altitude and hence we should expect a 300 Pa difference every time we test the device in a different location.  

### GUI = API: automated mouse clicks in Ableton
As mentioned earlier, we used Spitfire Audio Labs to synthesize sound.  

The top choice would be to work directly with [VST files](https://fileinfo.com/extension/vst) from Spitfire, but I have no idea how to do that.  
Therefore, we let [Ableton](https://www.ableton.com/en/) deal with Spitfire for us. In Ableton Live, you can import Spitfire Audio Labs as an instrument.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/spitfire.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/spitfire.png" alt="screenshot of ableton spitfire plugin" /></a>  

Okay! Let's use something like "Ableton API" to control Ableton then! Unfortunately, my research yielded no result.  

At that moment, I was reminded of [a project of Tom Scott's](https://www.youtube.com/watch?v=lIFE7h3m40U). Why not use macro/bot to simulate mouse clicks and key presses to control Ableton?  

And there we have it. I wrote [a Python script](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/py/py.py) to use mouse and keyboard to control Ableton GUI. The Python script receives commands from Processing via a TCP socket. Ha! I just [pwned](https://en.wikipedia.org/wiki/Pwn) my own laptop! Let's add [a firewall](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/py/network.py) to prevent strangers from hijacking my Python script.  

Just like this, Ableton became our real-time sound synthesizer, at least for the 22 remaining days of the free trial.  

### Teach Processing music theory
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/teach_proc_music.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/teach_proc_music.png" alt="Code snippet that defines chords" /></a>  

### I2C infinite wait
Once in a while, our program froze.  

Investigation showed it was Arduino that stopped.  

Further investigation showed that whenever an MPU6050 library function was called, there was a slight chance of <i>no return</i>, blocking the Arduino code execution.  

Both the air pressure sensor and the gyroscope use [I2C communication protocol](https://en.wikipedia.org/wiki/I%C2%B2C) with Arduino. Looking into the [MPU6050 library code](https://github.com/ElectronicCats/mpu6050), I found out that they did not enable `timeout` when they receive bytes from the sensor via I2C.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/timeout_arg.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/timeout_arg.jpg" alt="I2CDev provides a timeout argument" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/timeout_call.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/timeout_call.jpg" alt="But mpu library supply no timeout argument" /></a>  
I suspect this is the problem. When a bit is missing, Arduino would wait for the 8th bit but the sensor would never send anything, manifesting an infinite wait.  

The only real solution would be to rewrite the library, which I don't want to do. Instead, I just improved cable connection and minimized the number of calls to the library. The less you call, the less probable Arduino will freeze. Yes, sometimes avoiding the problem is the solution.  

### Note on & note off for ADSR
Previously, we didn't have [note on and note off](http://www.music-software-development.com/midi-tutorial.html). When you don't blow, a key is pressed down with dynamics = 0. However, that implementation resulted in a less expressive sound texture.  

We added a threshold of air pressure that triggers note on and note off. Now, the pre-programmed ADSR (Attack Decay Sustain Release) of Spitfire Audio can finally be heard.  

### Gyroscope calibration, the Earth, and the Ring Platform
A fun thing you will notice if you have a gyroscope: the reading is non-zero even when the gyroscope sits still!  
I thought, this could be the rotation of the Earth! But it isn't. The numbers don't add up.  

It turned out gyroscopes require calibration. You basically offset the X Y Z angular acceleration reading by a constant value. It's not hard to do: you just let it sit still and take its reading to be the offset.  

Our MPU6050 needed frequent recalibrating. Another reason we made the Ring Platform (mentioned above) is for easy recalibrating: we recalibrating it before the player takes the ring from the platform.  
<a href="https://media.giphy.com/media/QAgOr5guif0rAw87rX/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/QAgOr5guif0rAw87rX/giphy.gif" alt="hand take ring off from the platform" /></a>  

### Synchronize BGM
Our BGM for Scaffolding Mode is downloaded from [YouTube](https://baike.baidu.com/item/YouTube). After analyzing it in [Audacity](https://www.audacityteam.org/), we discovered there are 3.20000 seconds in a measure. Our Processing sketch basically synchronize with the BGM via [this code](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/proc/bgm.pde).  

"LOOKUP tables make things especially easy." - line 26 in [bgm.pde](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/proc/bgm.pde)  

### Sustain 
Tristan noticed that the notes cut off too suddenly! So we added Python-level sustain. Now, breathing does not interrupt your music.  

See line 35 & 67 in [py.py](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Final_project/py/py.py)  

## Humans using Simplinstrument
My original imagination of using <b>simplinstrument</b>:  
<a href="https://media.giphy.com/media/fuWWOBnnobMeikS2RL/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/fuWWOBnnobMeikS2RL/giphy.gif" alt="Me waving hands" /></a>  

How people actually use <b>simplinstrument</b>:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/Ki.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/05/Ki.jpg" alt="Ki playing the instrument" /></a>  

<a href="https://media.giphy.com/media/fubEXJzLvvMB47zG9Z/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/fubEXJzLvvMB47zG9Z/giphy.gif" alt="Rudi playing the instrument" /></a>  

## Conclusion
You interact with <b>simplinstrument</b> by letting it help you make music, hear the music you make, and show to people. It does not directly echo with my definition of interaction (giving and receiving attention). It is not emotional or artistic; just a tool for artistic expression.  

If there was more time, we would like to make everything wearable and wireless.  

It feels amazing when your flute respond to your breath. We started out wanting to make the experience of playing the flute more accessible. I think the result is satisfying. If we can enable more people to express more in music, it's worth it.  

## Make your Simplinstrument
### Buy these: 
Arduino Uno  
MPU6050  
BMP085  

### Make these:
A box to enclose BMP085. Leave two holes for air to come in and go out.  

A ring to fix MPU6050 on. Preferably Velcro, for different finger sizes.  
<a href="https://media.giphy.com/media/ZbHVlepAv5xItNlwOR/giphy.gif"><img class="size-medium wp-image-796" tabindex="-1" src="https://media.giphy.com/media/ZbHVlepAv5xItNlwOR/giphy.gif" alt="Design of the ring" /></a>  

### Download these
[Arduino](https://www.arduino.cc/), [Processing](https://processing.org/), and [Python](https://www.python.org/).  
Ableton Live, Spitfire Audio LABS: Strings.  

### Wiring
Connect BMP 085 to Arduino: VIN/VCC - 5V; GND - GND; SCL - A5; SDA - A4  

Connect MPU6050 to Arduino: VIN/VCC - 5V; GND - GND; SCL - A5; SDA - A4; AD0 - GND; INT - 2  

### Code
Download code from [my Github](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai). All code is in the "final_project" folder.  

You may need to change the `TRUSTED_IP` list in py/network.py  

py/ is the project Python code.  
ardu/ is the project Arduino code.  
proc/ is the project Processing code.  
MPU6050_calibrate/ is for calibrating the gyroscope. It outputs the offset.  

The above is all you need. The below is not important.  

BMP085test/ is for testing the air pressure sensor.  
gyro_math/ is my attempt of tracking motion.  
MPU6050_full_rotation/ is nonsense.  
MPU6050_test/ is for testing the gyroscope.  
QuaternionConjugateTest/ is the code I used to see if "conjugate" meant what I imagined.  
STLs/MouthPieceAdaptor.stl is a 3d-printable mouthpiece.  

### Get Help
Contact Daniel Chin at [nq285@nyu.edu](mailto:nq285@nyu.edu)

## And... 
Tristan and I would like to appreciate all who supported.  

Thanks to Rudi for lending us the MPU6050.  

Thanks to all user testers and all feedbacks.  

Thanks to Nick, Tristan, and Leon for the suggestions.  

Thanks to Marcela for the project guidance and all the lectures.  

All gifs are hosted on Giphy. Those with people's faces are set as private CORS.  
