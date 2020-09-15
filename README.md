## Inspiration
We came up with the idea while waiting in line in recent times, we all noticed practicing social distancing while still preserving our place in the line can be extremely difficult, on one hand you don't want to lose your place in line by staying to far, but due to recent time crowding with a lot of people can be very dangerous for your health.

So we thought, why do we all have to crowd up in here? Technology can allow us to organize a line without actually being present, that way we can both stay safe and stop wasting our time waiting in lines.

## What it does
noline is a web app that allows users to create and manage queues of people for any purpose, you can easily create a new line and get an easy screen which contains a qr to join the line, and a range of ways to join it.
from the user side, you can join the line easily, and leave your phone number so you will be notified when your line will arrive, while monitoring how much time you have until its your turn :D

## How we built it
We used the flutter framework to build the project, since flutter just launched an option to use their technology to build web apps, and we thought it would be an awesome learning experience! for the server side we used firestore and firebase for the database that manages the clients, lines, and sms notification service. and for actually sending the sms messages automatically, we used a nodejs server which uses the Twillio platform (right now in trial mode :D), and will allow users to leave their phone number and get an sms message when their turn is coming soon, and they should get near the line.

## Challenges we ran into
We wanted to make the app as accessible as possible on one hand, and also allow people that are not used to messing with complicated technology to join it easily. which created a big challenge.
In addition we wanted to allow line creators and managers create and manage the line in seconds, and with no need for additional equipment other then their phone / tablet / pc.

## Accomplishments that we are proud of
Setting up a custom QR code for each line which will be auto generated was an extremely difficult challenge, also working for 2 days intensively as a team was crazy fun :D
Setting up the nodejs server which sends SMS message automatically was also a great challenge we managed to overcome, and are extremely proud of finishing.

## What We learned
We each learned a lot about new programming languages (some of us didn't use flutter/dart before and for sure nodejs :D), usage of complicated frameworks, and setup of servers that will run automatically with our products on them was an amazing learning experience. Also working as a big team (5 people) was very intensive and we had to use git intensively to keep one another in tact, which can get hard while working fast on a project.

## What's next for noline
Our first goal is to get noline on more platform other then the web, and upload an app to the google play and IOS stores for easier access for users who can download those apps.
We also want to get our SMS server connected with a premium twillio account which costs more than we could afford for now.
And finally it would be great to finish up so more nice touches on the app, improve security with password for each line manager, allow them to go back on the line in cased they missed people, and allow them to reset the line easily.
We are crazy excited for this project and want to continue working on it and get it out there after this hackathon :D
