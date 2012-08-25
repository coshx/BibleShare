BibleShare
==========

Online group bible sharing tool

Demo: http://bible-share.herokuapp.com/

Description:
======
Bibleshare provides an useful tool for online group bible sharing/discussion. 
One can enter something like John 13:1-17 and the passage will be created. 
People can post their thoughts and meditations about the scripture. 
The passage will be visible as people write their thoughts, so they don't have to move back and forth between monitor and bible. 
If one wants to refer to another passage, he can type something like @Rome 3:31@ and it will display the verse in the post. 
People can comment on individual post. All posts will be visible at the same time, so no going back and forth is necessary. 
A scripture can be either made public for open discussion and sharing, or private for closed group sharing.

Passage:
======
- Passage has 4 components: title, bible, scripture, and content.
The 'bible' field is what you enter when you create the passage. 
- Examples
  - Single verse 'John 3:1'
  - Verse range 'John 3:1-5'
  - Cross-chapter range 'John 3:18-4:25'
  - Separate verses 'John 3:1-5; Romans 3:2-5'
  - Abbreviation 'Rom 3:2-5; Gen 2:2-5'
- It will render the scripture by parsing an xml and store it to its scripture field.
- It's supposed to display the pre-parsed 'scripture' field. However, the current version is parsing the xml by using 'bible' field every time the passage is displayed.
I made it to parse it every time it's shown, so that I can modify the format. I forgot to change it back before the time limit :(
- There are two types of passages: public and private.
  - Anyone can create public passages and only registered users can create private passages.
  - Anyone can access and post on public passages.
  - An user can give permission to others users when creating a private passage so they can read and post on the private pasage.
    - Currently, it creates dropdown menus that shows the names of all existing users.
    - The permission list cannot be modified later once it's created (couldn't implement it due to lack of time).


Post and comment:
======
- Posts belong to a passage, and comments belong to a post.
- Posting and commenting can all be done in one screen while being able to read all contents that belong to the passage.
- Editing contents can all be done in one screen as well.
- Content owners have the ability to delete its sub-contents.
  - Passage owners can delete its posts
  - Post owners can delete its comments
- Contents that are created by non-registered users cannot be edited and can only be deleted by its parent-content owners
  (need to add admin and enable the admin to have control over those contents)

Tagging bible veres:
======
- Users can tag bible verses in their posts and comments.
- You just simply surround the verses with @ signs and and it will display the full passage once it's submitted.
- Examples
  - Hi I like this passage. @Romans 3:2-5@ is also good!
  - More vereses here. @1Cor 2:5; 2Cor 3:6@
  - @Gen 2:5@ and also @Rev 2:5@

To Judges:
======
I ran out of time at the end, so it might have some flaws. 
I doubt that you'll bother cloning the repo and running spec tests locally, but just in case you do, some acceptance tests are failing because I made last minute change to views.
The biggest flaw is that contents are not displaying who wrote the content. It could be an easy fix, but just didn't have enough time at the end.
I was planning on seeding some data so that you can use the app right on the spot without creating any contents and registering, but I ran out of time.
I apologize for that. However, I created some users and posted some contents on the demo site, so that you can see how people can use this application.
You can interact with the public contents in the demo site right on the spot (w/o signing in). 
For using private share, you'll need to create two accounts, sign in and create a private passage with permission for the other account you created.
The private share should be only accessible by those two accounts.
It was my first hackathon and it was a great exprience. There are definitely lots of rooms for improvement and I hope to hack on it whenver I get the chance.
I hope you enjoy this app! Thank you.
