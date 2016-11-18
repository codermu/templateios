# templateios

Template for creating a new Ios App with Oauth2 Protocol ready,

writen in Swift 3, Xcode 8 is required to open this project

features included in this project :

- Login (token will be stored in keychain)
- Social Login (Facebook, Google)
- Sign Up
- Forgot Password / Create a new password using recorvery code
- Dashboard (show stored login token from keychain)

How to use this project.

- instal cocoapod https://cocoapods.org/
- run pod install
- change app bundle id with your bundle id

![Alt text](https://monosnap.com/file/S7aIpK2zJwpmLmLspdByd4ULTcwk7T.png)

- activate keychain sharing

https://monosnap.com/file/RE84wrXjRlBF4PPtQWwXDSYZ9sHxzw

- update facebook appid in Info.plist (follow instruction here https://developers.facebook.com/docs/ios/getting-started#xcode)

![Alt text](https://monosnap.com/file/Iqbtdo2PzdNRBJZToQlXsFtusb37TC.png)

- update GoogleService-Info.plist and update Url Types on Project Info

![Alt text](https://monosnap.com/file/ktNCTM4LAfhsWZiBFRGvqgy6hMGWi1.png)

![Alt text](https://monosnap.com/file/MBVbaaW3nHK5bCZd4iHBqAbYtuTwJ1.png)

- clean  project, then build and run the project
