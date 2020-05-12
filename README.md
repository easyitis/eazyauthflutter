## Integrate EazyAuth with Flutter
This repository consists of sample code to integrate EazyAuth to Flutter. Visit https://eazyauth.com or https://www.youtube.com/watch?v=buw9inQ1HWc for details.

## What is EazyAuth
EazyAuth makes 2 factor authentication easy. It provides a set of APIs to authenticate your users through one time passwords sent by email.

## Why Use EazyAuth
- Works on all devices.
- Secure
- Maintains Privacy
- Simple
- Economical
- Ensures peace of mind

## How It Works
It's Easy - just 2 APIs
1. Call EazyAuth Find User API - it finds the user record based on the email address and even creates one if it doesn't already exist. An email is sent to the user with a random one time secret. The secret is not stored anywhere, even in our database. (Hint: it's stored as a hash).
2. Once the user enters the one time secret, call EazyAuth Verify User API to determine if the user is verified or not. At this point, your app / site can decide how to proceed.

## Steps to Integrate with Flutter
To get started, login to eazyauth.com and get your integration id / secret key

Next, create a basic Flutter project using flutter create. Once done, we integrate EazyAuth to the Flutter app
1. Add http (mandatory) and validators (optional) dependency in pubspec.yaml or copy the file from this repository.
2. Copy the dart files in the lib folder of the repository.
That's it. You have linked EazyAuth to Flutter.
