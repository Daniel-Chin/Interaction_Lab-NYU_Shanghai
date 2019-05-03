Instructor: <b>Marcele</b>  

This is a write up for Interaction Lab SP18 [Recitation on Nick's Birthday](https://wp.nyu.edu/shanghai-ima-interaction-lab/recitation-9-media-controller/) on Apr 28, 2019.  

## Heat-sensitive webcam
[video width="960" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/demo-4.mp4"][/video]  
The webcam image turns red when heated up, and turns blue when cooled down.  

## Source code
[Arduino code](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Recitations/r10_Nick_Bday/ardu/ardu.ino) and [Processing code](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Recitations/r10_Nick_Bday/proc/proc.pde) on my Github.  

You can see I wrote a signal-smoothing feature in `loop()`. The mode of 20 sensor values is sent to Processing every 0.1 second.  

## Reflection
The interaction this time is very basic. I am most impressed by my laptop tinting every frame from the webcam in real time.  

Inspired by <i>Computer Vision for Artist and Designers</i>, I think using pre-built frameworks to analyze video would be something interesting to do.  
