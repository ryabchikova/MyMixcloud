## Intro
Application for browsing and interacting with your data from www.mixcloud.com  
Based on [Mixcloud API](https://www.mixcloud.com/developers/)

## Why did I decide to create it?
I'm music lover, DJ and a big fan of Mixcloud service. So, it became interesting to look deeper at it's internal structure and try to present my vision of the user interface.  
My mixcloud page https://www.mixcloud.com/elena-ryabchikova/

## How to try app
- If you have mixcloud account, use your username when login.
- If you haven't  mixcloud account, you can login with any existing username. So you can see user's open data. This is safe because read-only mode is currently supported. In future this option will be disabled, you will need username and password to login.  
   For example, to watch my account  (https://www.mixcloud.com/elena-ryabchikova/), you should use 'elena-ryabchikova' as username.

## Features are planned
- authorization
- follow, add to favorites, repost actions
- search across uploads, users and tags
- deep links for listening audio in official Mixcloud application (audio streams are not available through the Mixcloud API)
- several color themes
- may be some interesting graphics presentation of user's statistics data

## Revision history

###### 02.08.2019. Version 1.0.0
- min iOS version 8.0
- First working version. Read-only mode.
- Available: Listening history, Favorite shows, Following list, User profiles.

###### 26.09.2022. Version 2.0.0
- min iOS version 15.0
- Global refactoring of code, excluding UI, layout, view models.
- Transition to Swift async/await
