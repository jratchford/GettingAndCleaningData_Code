# This is the last project for this class.
I need to have a readme file!

The code assumes the data is in a folder called "data" in the file you are running the script from

Basically, the code looks like this 

## first some stuff to get things running
1) Function to get data
	Though it is not written, i did check to make sure all the tables were the expected length going in
2) Function to clean labels <- I spent the most time on this. Regular expressions!
Eventually I decided I only needed to clean the labels for the columns I was keeping

## Then the code starts
1) Get the activity labels
2) Execute #1
3) Extract mean and sdev. Right now, I am not keeping MeanFreq, but you could if you want
4) Here I split off the activity and subjectID and all the measurements to handle the cleaning separately
	a) on the "hold" data: Replace the activity ID with the activity 
	b) on the "data" data :Replace the column names with a new readable column name
6) Bind the hold and data back into data with cbind
7) Group the data
8) write a file.

I put in some features like you can change the name of the activity and subjectID columns

Have a nice day