## Context and significance
My previous research (Group Project) helped me define interaction, so that I create something interactive for the midterm. The projects and interactions I researched for the Group Project were: the Alexa Parasite, and the Smart Home Counterspy. 

### Previous research, quoted from an [earlier post](https://wp.nyu.edu/shanghai-ima-documentation/foundations/interaction-lab/nq285/group-project-blog-interaction-attention-by-daniel-chin/)
#### [Parasite of Alexa](https://www.creativeapplications.net/objects/alias-a-teachable-parasite-for-your-smart-assistant/)  
This project is a Man In Middle between Amazon Alexa and the user. It acts as a firewall, protecting the user's privacy. The device sits on top of an Alexa, playing a random noise to the Alexa's microphone. Only when the device hears the user speak specific wake words will it stop playing the random noise for a while. 

I think it is a good initiative, but not an interactive device. Its idea very well manifest social science principles like the Division of Power and Mutual Supervision. It protects privacy. However, The human uses it as a mere tool. The "encapsulation" is so good, the user may as well forget about the existence of the device! It is not a bad thing, just not interactive. 

#### [Smart Home Counterspy Agent](https://www.creativeapplications.net/member-submissions/scout%e2%80%8a-%e2%80%8aa-smart-home-counterspy-agent/)
This project is a router for smart home devices. It displays the traffic of each smart home device with intuitive graphics. The purpose is to reveal to the user how much data their smart home devices upload every day. 

This one is interactive. The user feels they are actively protected. The device communicates with the user. Every time the user looks at it, the user can feel the amount of thought the device put into its job when the user was not around. That creates emotional sympathy. This is what I mean by "<b>a dead thing making a living thing feel they are given attention.</b> "

#### Conclusion
And hence my definition of interaction formed: interaction is giving and receiving attention. 

Interaction with physical computing is:  
<b>A dead thing making a living thing feel they are given attention. </b>

### Significance of Laser Arcade
[video mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/proto_demo.mp4"][/video]  
Laser Arcade is a laser aiming game + drawing machine control. I think the later part distinguishes it from general laser aiming games (field CS, field PUBG...) in the following aspects:  
1. The drawing machine control is difficult to master, adding explorability and depth into the game.  
2. The drawing machine control is tricky, and gives frequent surprises to the players. This is emotionally engaging, and ensures a level playing field for beginners.  
3. The complexity and predictability of the control mechanism invites players to formalize their understanding of the control. That may inspire players to pursuit Engineering and Physics. 

I envision Laser Arcade to appear in arcades, for kids to play. It is fun, and it also inspire people to become Engineers, as mentioned above. 

## Conception and design
When we deigned Laser Arcade, because the idea was pretty simple and playable, we spent the most effort on ensuring the balance and competivity of the game. The way we understand our users to interact with Laser Arcade is for them to play it repetitively. Therefore, we designed a lot of details, such as placing the target in opposing directions for the two players, letting the target rotate, uncorrelating the rotation of the two targets, offsetting one player's height to make sure there is no "safe zone" for either of the player to hide. We wanted to encourage aggressive game play and fast decision making. For the same reason, we set the winning animation to be very short, enabling players to rematch quickly, creating a game flow.  

Because we pursuit playability and competivity, we chose materials and forms that provided the best stability. For example. the V-nails that came with the drawing machines only fastened the drawing machine arms very loosely, and we were unsatisfied because the arms could shake uncontrollably. We replaced the V-nails with nuts and bolts for higher control precision. Also, we used rigorously supported 3D-printed frame structure to hold the servos, in order to minimize the deformation of the machine during game play. An alternative would be to use cardboard, which wouldn't be as strong.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/skeleton_model.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/skeleton_model.jpg" alt="3D model of skeleton" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/skeleton_photo.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/skeleton_photo.jpg" alt="photo of skeleton" /></a>  
The result is a durable hardware:  
[video width="272" height="480" mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/durability.mp4"][/video]  
And a nicer overall appearance:  
[video mp4="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/demo-2.mp4"][/video]  

We also pursuit a friendly control. For example, the potentiometer is small and hard to fiddle with. So we printed "handle V1".  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/diamond_handle.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/diamond_handle.jpg" alt="photo of handle V1" /></a>  
However, during user testing, a lot of players thought the potentiometer was a joystick! We realized: the model looked like a joystick. Marcela recommended us to change the shape, and here we did:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/fusion_knob.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/fusion_knob.png" alt="model of handle V2" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/knob.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/knob.jpg" alt="photo of handle V2" /></a>  
"handle V2". It worked very well.  

## Fabrication and production
Tristan and I first made drafts on paper:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft2.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft2.jpg" alt="some drafts" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft1.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft1.jpg" alt="some drafts" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft0.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/draft0.jpg" alt="some drafts" /></a>  

And then we started 3D printing and coding. I used a python script to do serial communication with the two Arduino Unos.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/python.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/python.jpg" alt="python script running" /></a>  

Anti-noise technology is adopted for potentiometer input:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/antinoise.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/antinoise.png" alt="code snippet" /></a>  

I also created a communication protocol between two boards:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/rainbow.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/rainbow.jpg" alt="photo of two Unos connected" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/DistributedComp.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/DistributedComp.png" alt="Diagram of two Unos connected" /></a>  

During the user testing, many people asked: "What should my laser hit?" So we wrapped our light sensor with a bullseye:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/bullseye.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/bullseye.jpg" alt="Diagram of two Unos connected" /></a>  
It totally solved the mystery.  

Another player reported that the winning moment was too vague to tell and not cheerful enough. We want the winning moment to be "arcade-like", playful, and extra. So we added a sound effect with a strong attack.  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/sound.png"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/sound.png" alt="Diagram of two Unos connected" /></a>  
[audio mp3="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/p1-1.mp3"][/audio] 
[audio mp3="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/p2.mp3"][/audio] 
One of my favorite parts of Laser Arcade.  

Another player gave feedback that there is actually a "safe zone" on the right border of the play field. We fixed that by changing the target rotation range and skew it to the left.  

Here are our notes from User Testing:  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback2.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback2.jpg" alt="user testing notes" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback1.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback1.jpg" alt="user testing notes" /></a>  
<a href="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback0.jpg"><img class="size-medium wp-image-796" tabindex="-1" src="https://wp.nyu.edu/shanghai-ima-documentation/wp-content/uploads/sites/13761/2019/04/feedback0.jpg" alt="user testing notes" /></a>  


## Conclusions
The goal of Laser Arcade is to provide a fun and competitive experience with drawing machine mechanism. I think that is pretty much achieved, since every player liked the game and wanted to try times after times. It was very fun for the creators, too. Even the creators did not get bored of playing it. I know that's something rare.  

It also aligns well with my definition of interaction! The player definitely pays attention to Laser Arcade. In fact, the two players pay attention to each other, too. Tristan would argue that is more important. I agree.  

Ultimately, our audience treated Laser Arcade as a game. They tried to prevail in the game, and during that process, they have fun and bond with their friends.  

If we had more time, we would add win streak celebration and dynamic difficulty adjustment.  

From the failure of "handle V1", we learnt the hard way what a "Norman Door" was: a design that tells you to do the opposite of what you are supposed to do. We learnt the value of user-oriented design.  

Our greatest accomplishment is the collaboration between us two. It worked super well. Many times, I face a design challenge I can't solve, and I speak aloud, and Tristan provided creative solutions that would never have occurred to me. The same happens the other way too. There were frequent enlightenments. I learnt that when people from different backgrounds form a group they create surprising solutions. I cannot imagine how many more worthy interdisciplinary idea exchanges that we humans are not overtaking.  

## So what? 
Not a lot of people will remember Laser Arcade. For those who do, I hope it was a fun experience to remember.  

For me, the creation of Laser Arcade connected some neurons in my head, and gave me many more ideas regarding interactive projects and performances.  

I do believe Laser Arcade is an idea that works. A more matured production can totally be adopted in parties, arcades, ice-breaking activities, inspirational education for kids, or in VR environments. The unique experience that Laser Arcade offer makes the above possible.  
