BibleShare
==========

Online group bible sharing tool


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

ex)
1) single verse 'John 3:1'
2) verse range 'John 3:1-5'
3) cross-chapter range 'John 3:18-4:25'
4) Separate verses 'John 3:1-5; Romans 3:2-5'
5) Abbreviation 'Rom 3:2-5; Gen 2:2-5'

It will render the scripture by parsing an xml and store it to its scripture field.


- There are two types of passages: public and private.
Anyone can create public passages and only registered users can create private passages.
Anyone can access and post on public passages.
User can give permission to others users when creating a private passage.
Currently, it creates dropdown menus that shows the names of all existing users.
Only authorized users can view and post on the passage.


Post and comment:
======
- Posts belong to a passage, and comments belong to a post.
- Posting and commenting can all be done in one screen while being able to read all contents that belong to the passage.
- Editing contents can all be done in one screen as well (except editing passage..couldn't implement it due to lack of time)
- Content owners have the ability to delete its sub-contents.
  - Passage owners can delete its posts
  - Post owners can delete its comments
- Contents that are posted by non-registered users cannot be edited and can only be deleted by its parent-content owners
  (need to add admin and enable admin to have control over those contents)

Tagging bible veres:
======
- Users can tag bible verses in their posts and comments.
- You just simply surround the verses with @ signs and submit and it will display the full passage.

ex)
1) Hi I like this passage. @Romans 3:2-5@ is also good!
2) More vereses here. @1Cor 2:5; 2Cor 3:6@
3) @Gen 2:5@ and also @Rev 2:5@

To Judges:
======
I ran out of time at the end, so it might have some flaws. 
Some acceptance tests are failing because I made last minute change to views.
Contents are not displaying who wrote the content. And there might be more flaws that I'm not aware of.
I was planning on seeding some data so that you can use the app right on the spot without creating any contents and registering, but I didn't have time to do that.
I apologize for that.
It was my first hackathon and it was a great exprience. There are lost of rooms for improvement and I hope to hack on it whenver I get the chance.
I hope you enjoy this app! Thank you.
