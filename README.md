# DDROPP

DDROPP is more than just an app — it's a bridge to your most cherished memories. 

<img src="DDROPP/Assets.xcassets/AppIcon.appiconset/appstore.png" width="200"/>

Born from the desire to relive moments without barriers, DROPPPP ensures that every shared photo and video retains its full glory, free from the compression and device limitations that often dilute our most treasured souvenirs.

## Vision

Today, sharing media with friends after hanging out is so so so **so** (so so so) frustrating. Social media apps compress images, flooding conversations and are not really suited for that. AirDrop works well but excludes Android users, classic solution like Google Drive, Google Photos and cloud storage solutions are outdated and cumbersome. We're not in 2010 anymore.' It's annoying to constantly hound friends to send pictures after every gathering, turning joyful moments into boring follow-ups.

Enter DDROPP – a revolutionary solution that transforms how we share and preserve our memories. Imagine a central hub where all your media is unified, effortlessly bridging the gap between different devices and platforms. DDROPP envision to detect when you're out with friends and automatically initiates a drop session, gently reminding everyone to share their photos and videos. As simple as that, and everything becomes to much easier.

In a few bullet points of what it is today:
- Seamless high-quality media sharing. No compression, download all pictures as they were taken.
- Retrieve all events you participated, all the memories!
- See all your friend's drops on the event. You can scroll through all pictures at once (grid view) or organize it in a timeline manner (e.g. see the pictures Jason dropped 2h ago)
- As its root, Drop is just a big button. A big DDROPP button.

The future of memory sharing w/ your friends: 

- Auto-sync feature. Automatically starts drop session when you're hanging out with your friends, without manual intervention.
- Notifications. I want DDROPP to tell me when someone drops new picture, I want DDROPP to remind me to upload the pictures I've taken of my friends, I want DDROPP to know when I'm hanging out with friends to ask me if I want to start a drop session
- Intelligent sharing. DDROPP can only filter the pictures that are related to an event
- Automatic image processing. You can enable the feature to do some magical computation to make your photo look better. Dropping pictures with DDROPP will have its own style of rendering that is unique and very different compared to the others (need to good design vision here)


DDROPP is not just an app; it’s a movement. **It’s the habit everyone will want but that doesn’t exist today.** No more struggling to gather scattered media from friends, no more degraded memories, and no more exclusion based on device. DDROPP is here to make sharing and preserving memories a seamless, enjoyable, and inclusive experience for everyone



## Monetization Strategy

Many streams will be used.

#### Freemium

Everyone will be able to use DDROPP. I want to make it a habbit for every users, so DDROPP can be used without a single cent, to some degree.

Premium subscription features such as higher storage limits, exclusive filters, enhanced editing tools, and AI! I always take too many photos and I always dreamed about an app that can (really) pick the best ones.

I expect the subscription to work once users understand the value we're really offering to people, so I would start the Freemium with pretty big capacity, and lower it over time.

Once we provide a working product with all core features working and its unique mordern - mobile first - style, I believe users will be addicted to this service. 

This easily snowballs: if I use DDROPP I will advertise by myself for my friends to install DDROPP. They will advertise to their own group of friends. And so on.

In the future, strangers will be able to connect as well. Think about music festival, concert place, football game, etc. everyone will be able to drop pictures of this specific event and sharing the different experience they had. You will be able to live again this moment in another point of view.

#### Advertising

Non-intrusive sponsored ads, following the same design as the drop channels or dropped picture.

Premium subscription include an ad-free experience.

#### User growth related topic

Very aggressive Marketing & User Acquisition strategy. 

I truly believe that nothing exists in the market and the need is real. I've asked a lot of friends about this issue, and I feel like it's a very common pain point for everyone today.

Addressive marketing strategy includes social media campaigns & influencer marketing/collaboration (Tiktok, Instagram, Snapchat...). The market is real, and I'm targeting both Gen-Z & Gen-Y.


## App Architecture

The project follows MVVM for scenes, with Clean Architecture in different layers (use cases, repositories and service layers)

The entire app was built in SwiftUI.

Swift Package Manager was used to manage third parties. Reason behind is its integration directly within Xcode and ease of use (e.g. just need to drop a repo link and voilà)

Network layer is directly done using Apple's URLSession. The API calls were basic, Apple's APIs are straightforward enough to achieve what we want.

Manual DI via constructors. For a single screen app it is more than enough.

All API models are represented as DTO objects, which are mapped to domain models (=> represents our feature & decorrelate ourselves from API dependencies). 


### Third Parties

 - RxSwift: Primarily used for asynchronous data flow management. I opted for RxSwift over Combine because I'm more familiar with it, to enable me for faster development given the time constraint where every minute can make a difference.
 - Kingfisher: Download & cache remote image. Lightweight & powerful, I did not want to reinvent any wheel here.


### Endpoint

The app does real API requests.

I've put some examples in the app about API validation rules.

I've very quickly prototyped some mocks (static data):

#### Get channels
- GET https://6690ef0926c2a69f6e8db7bc.mockapi.io/api/v1/channel

Returns an array of channel. A channel represents a dropping event. You go to a music festival? Create a channel of this event and everyone participating will be able to drop pictures of this event in this channel.

#### Get drops by channel id
- GET https://6690ef0926c2a69f6e8db7bc.mockapi.io/api/v1/drop

Returns on array of drops for a specificed channel. All pictures that were dropped by your friends.


### Improvements

If I had slightly more time, key area product focus would be:
- Implement download capability to save images
- Create the light tunnel to create a new channel (as simple as the tricount one for example. just inviting friend's mobile number or mail and that's it! They receive a link and they're in')
- Dropping pictures should be an addictive action (that's the core of the product!), so I would invest even more animations and design in the dropping action

If I had more time, key area technical focus would be:
 - Improve Navigation. I'm not super happy w/ how scenes navigation are currently handled.
 - More stricter MVVM pattern
 - More robust Network layer (headers, query params, retrial mechanisms, etc.)
 - Improve unit tests. 
 - Error handling

## Misc

Product name inspired by [https://www.youtube.com/watch?v=NYk9e-3ZpoY](French 79 - DDROPP). Once I figured out what I wanted the build, this was natural to take this name.
