# robotarium-challenges
A repository for all the Robotarium challenge problems!

# Aerospace Hackathon

This repository contains the files for the Robotarium challenge problem for the 2016 Aerospace hackathon! 

# High-level Information 

At a high-level, you copy and modify the main.m file (the name doesn't matter) then submit it on the website (http://www.robotarium.org).  The server will load the required files, initialize your robot, then give you feedback on how well you completed the challenge.

# What You Have to Do 

The run_aero_challenge scripts are what the sever will run to execute your main script.  You shouldn't modify these files.  You don't need to submit them on the website, only submit your main file, but your script won't work if you do.  We will load the requisite environment files to run your script.  

1.  Run an environment.m file to load in the obstacles 
2.  Initialize your robot to the start position
3.  Drive to the goal position while avoiding obstacles
4.  Once you're happy, submit your code to the website! 

Feel free to make a couple different "main.m" files in order to complete each challenge.

# Additional Comments 

Here are some additional comments on the above 4 commands.

1.  The server will load the required environment file based on the challenge that you selected on the website 
2.  You should initialize your robot to the start position.  Don't worry about hitting obstacles when initializing your robot to the start position - the server will make sure that your robot is at the 'start' position before running your script.  Some code that accomplishes this task is in all of the run_aero_challenge files 
3.  Fairly straighforward
4.  Make sure you select your challenge on the website under options for each experiment.
5.  All the obstacle utilities will be loaded on the server, so you don't need to copy these functions into your main script.  Conversely, you could also just submit these files along with your main script.

# About the run_aero_challenge Scripts 

Don't worry about running these.  You should simply load the environment file, initialize your robot, and try to go from start => goal, without hitting obstacles.  These are included so that you can see how the server will run your script.
