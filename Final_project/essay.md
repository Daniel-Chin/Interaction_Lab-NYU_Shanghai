<b>Simplinstrument</b> 简单乐器

Regardless of language and culture, music is many people’s dearest form of art. We use music to express, understand, and remember.  

Unfortunately, the experience of expressing yourself with music is locked away for most people. Learning to play an instrument is hard. Many refuse to try. More give up before yielding any results. How can we let more people taste the feelings of musical expression?  

<b>Simplinstrument</b> will be a solution that [Tristan](https://wp.nyu.edu/shanghai-ima-documentation/wp-admin/edit.php?post_type=post&author=41309) and I present. <b>Simplinstrument</b> has to be <i>easy to control</i>: A kid with no musical training should find it intuitive to play with. It should also be <i>expressive</i>: the player should have robust control over the pitch, velocity, and modulation.  

Our goals are:  
<ol><li><b>Simplinstrument</b> will be easy to learn;</li><li><b>Simplinstrument</b> will be fun to practice;</li><li>With enough practice, you can produce quality music with <b>Simplinstrument</b>.</li></ol>

The monotonic instrument, <b>Simplinstrument</b>, will consist of a mouthpiece, a pitch glove, and a modulation glove. The mouthpiece will have an airflow pressure sensor to control the velocity. The pitch glove will have a gyroscope for pitch input. The modulation glove will have an accelerometer who readings will be Fourier Transformed into modulation parameters. The audio synth will mainly take place in Python, which will connect to Processing with localhost sockets.  
We will first try to make the mouthpiece, because I think the most risky implementation in this project is the airflow pressure sensor. This should be done before May 3rd.  
Everything else is not too much work.  

My preparatory research gave me [a list of ideas](https://github.com/Daniel-Chin/Interaction_Lab-NYU_Shanghai/blob/master/Ideas.txt) for the final project, and <b>Simplinstrument</b> is only one of them. Being expressive in nature, <b>Simplinstrument</b> promotes interaction between multiple humans by unlocking their musical ability to express themselves and understand others.  

<b>Simplinstrument</b> is actually one of my dream instruments. (My first dream instrument is brainwave2audio.) It will be valuable to whoever find it fit to their musical expression. <b>Simplinstrument</b> is inspired by the [Theremin](https://www.youtube.com/watch?v=K6KbEnGnymk) and the [REMI](https://www.youtube.com/watch?v=1TchTxoj5BU). The design of the airflow pressure sensor is 
taken from [REMI by M.J. Bauer](http://www.mjbauer.biz/Build_the_REMI_by_MJB.htm). We want to make everything simpler.  
