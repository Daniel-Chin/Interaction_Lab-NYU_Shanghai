Instructor: <b>Marcele</b>  
Recitation partner: <b>Linhui</b>  

This is a write up for Interaction Lab SP18 [Recitation on Arduino Basics](https://wp.nyu.edu/shanghai-ima-interaction-lab/recitation-2-arduino-basics/) on Feb 22, 2019.  
## The circuits
Scheme of fading LED ¡ý  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/1-2.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/1-2.jpg" alt="scheme of circuit" /></a>  

Fading LED working ¡ý  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/1.mp4"][/video]  

Scheme of tone melody ¡ý  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/2-2.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/2-2.jpg" alt="scheme of circuit" /></a>  

Tone melody working ¡ý  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/2.mp4"][/video]  

Scheme of speed game ¡ý  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/3-2.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/3-2.jpg" alt="scheme of circuit" /></a>  

Speed game working ¡ý  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/3-2.mp4"][/video]  

Scheme of 4-player speed game ¡ý  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/4.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/4.jpg" alt="scheme of circuit" /></a>  

4-player speed game working ¡ý  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/02/4-1.mp4"][/video]  

## Problems and how we solved them
We encountered several problems during the recitation.  
#### 1. Floated inputs give random noise  
In 3. Speed Game where two buttons are supposed to serve as input, we accidentally floated PIN 10 and PIN 11, resulting in random noise received. Once the game started, the counter rapidly added up to ten, and a random player wins (Without any human intervention).  
We checked the schematic and found out that we missed two cables connecting the other side of the resistor to GND. We added them, and the circuit worked correctly.  

#### 2. PIN 13: so special  
In 4. Four-player Speed Game, we decided to use PIN 13 as one of the LED outputs. We observed a green LED on the Arduino board lighting up. We remembered that the recitation talked about PIN 13 earlier. PIN 13 is connected to the green LED within the board.  

## Questions and my answers
#### Reflect how you use technology in your daily life and on the circuits you just built. Use the text <i>Physical Computing</i> and your own observations to define interaction.  
I can imagine the non-technology version of the technologies we have. Imagine a laborer is hired to do repetitive work in place of a machine. We would have to wait longer for the same jobs to be finished, and the laborer would be highly bored. This applies to a lot of use cases of technology. In the Speed Game, we can imagine instead of a circuit we hire a human referee to count our clicks and announce the winner. That would work less well. This is part of the charm of technology. The other part emerges where the speed of processing is so different from that of humans' that the user experience goes through a qualitative change. That is the unique interaction that physical computing monopolizes in.  

So far, what do human interaction monopolizes in? "grand sweeping gestures" (Igoe and O'sullivan. <i>Physical Computing</i>. "Introduction", xix.), or modes of expression other than a screen of pixels and some speakers. To cross the differences between human interactions and traditional computer interactions is at the key of the development of physical computing. 

#### If you have 100,000 LEDs of any brightness and color at your disposal, what would you make and where would you put it?  
First thing first, I would put some of them behind the buttons in NYU Shanghai Pudong Campus elevators. Right now they have gray numbers on a silver background, which a lot of people (like me) can't see. I would give the numbers a <span style="color: #808; text-shadow: 0 0 10pt #c08">soft violet glow</span>, enhancing accessibility, making the Academic Building more inclusive.  

That still leaves us with a lot of LEDs. I would like to attach them onto the handrails of all stairways in Shanghai metro stations. The LEDs should animate some color bands moving in the direction that passengers are supposed to go. That prevents reverse walking. Also, the speed of the color bands should be just a little higher than the average walking speed of Shanghai metro takers. That is a subliminal manipulation aiming at accelerating the people to walk up/down the stairs.  
