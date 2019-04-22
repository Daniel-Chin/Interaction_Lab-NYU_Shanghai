Instructor: <b>Marcele</b>  
Recitation partner: <b>Andres</b>  

This is a write up for Interaction Lab SP18 [Recitation on Drawing Machines](https://wp.nyu.edu/shanghai-ima-interaction-lab/recitation-4-drawing-machines/) on Mar 15, 2019.  
## One Revolution
Demo:  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/one_revolution.mp4"][/video]  

## Knob Motor
Demo:  
[video width="300" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/knob.mp4"][/video]  

Scheme:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/scheme-1.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/scheme-1.png" alt="scheme of circuit" /></a>  

## Drawing Machine
We didn't have time for the drawing machine when the recitation ended.  

## Problems and how we solved them
There was only one problem today:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/noise.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/noise.png" alt="volatile reading on Serial plotter" /></a>  
As the screenshot shows, the potentiometer input has a random noise of ¡À2. As a result, the stepper motor shakes restlessly.  
We added the following code to solve the problem:  
```c#
  delta = poten - last_poten;
  if (abs(delta) >= 5) {    // smart technology
    last_poten = poten;
    myStepper.step(delta / 4);
  }
```
Which completely filtered out the noise:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/anti_noise.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/03/anti_noise.png" alt="flat line on Serial plotter" /></a>  
So it was a success.  

## Questions and my answers
#### What kind of machines would you be interested in building? Add a reflection about the use of actuators, the digital manipulation of art, and the creative process to your blog post.

The drawing machine actually gave my midterm partner and I our idea for the midterm project. Amazed by the actuators, we decided to utilize the mechanism of drawing machines on a vertical plane. The user would control two servos to move a point in 3D space. 

The actuators were controlled by two parameters: speed and steps. According to Tristan, the `step()` function is blocking, and it only returns when the stepper motor reaches the target position. That is very different from servos!  

The drawing machine is especially fun because it involves two players. It was unfortunate that we didn't have time to do step 3, but we observed other students do it. The creative process was full of unpredictability.  

#### Choose an art installation mentioned in the reading [ART + Science NOW, Stephen Wilson (Kinetics chapter)](https://drive.google.com/file/d/1MH0D7mTve4KQVn9FJ0KqXWa2TgGuJkPR/view). Post your thoughts about it and make a comparison with the work you did during this recitation. How do you think that the artist selected those specific actuators for his project?

This reading reminds me of a childhood experience.  

In elementary school, I saw an article in the Children's Newspaper about a set of VR equipment. It used cameras to track human motions. A pair of gloves with nano-needles simulated haptic experience and made your fingers feel texture, vibration, temperature, and friction. I was deeply amazed by the technology.  

Growing up, I have become increasingly "careful" regarding what to be amazed by. Ego. Not a good thing. It was like, if I thought something non-cool as cool, that would indicate my lack of taste. What is interaction? What is not interaction? Let's think of a definition so advanced that I can use it to privately look down upon other people's projects. Such was the way I tried to distinguish myself.  

The reading made me miss the kind of simple amazement I had in elementary school. The reading mentions a lot of projects that aren't so useful. Many of them are "artistically not to the standard", too, if you know what I'm saying. There could be critics, "look at those people, wasting resources, making useless things!" That is a valid opinion, and it makes part of me feel ashamed to like those interactive projects. However, what is my honest feeling? I like them!  

That is when I realized, just like how one cannot be "all-round political-correct", one cannot always address every doubt regarding their passion. Sometimes it is okay to let it pass and be content with honest feelings. Maybe the interactive arts do not solve social issues; maybe they are artistically childish; maybe they use out-dated technologies that are not "fashionable" anymore; but I like them. I don't think everything needs to find their meanings right away.  

Comparing their works to what we made in the recitation, I think their works shout originality. Looking at them, you can feel the creators try their best to express what they have to express. You can feel the creators tweak the projects in the exact way they liked them to be. Artistic creation is dictatorship. Appreciation of artwork is democracy. I vote up for their works.  

I think the artists selected the actuators based on the required power output, precision, required speed, size constraints, safety risk, and heat dissipation.  
