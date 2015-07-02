# Simple Video Player

A simple iOS app built to demostrate playing video using [VideoLAN's](http://www.videolan.org/vlc/) [MobileVLCKit](https://wiki.videolan.org/VLCKit/#Building_the_framework_for_iOS).

## App features

* Play .mp4 video files stored within app
* Video gallery created using UICollectionView
* Play/pause control
* Mute/unmute video control
* Autolayout of video when device changes orientation

## Pitfalls

### Compilation issues

Initially I tried importing MobileVLCKit through Cocoapods, but the project always failed to build and throws an "Undefined symbols for architecture armv7" (if building for device, i386 will be for simulator builds).

Probably Cocoapods is hosting an incomplete version of MobileVLCKit, or missing dependencies? So I decided to build the framework from source and manually add it the Xcode project, along with the dependency libraries (followed the sample iOS Xcode project provided by VideoLAN), but the same error occured again.

Finally I decided to try the nightly builds as some developers suggested, but still no luck with getting a successful build.

After some research online and combing the VideoLAN forums, I found out that if the deployment target of the Xcode project is higher than 6.1, instead of using libstdc++.dylib, libstdc++.6.0.9.dylib should be used instead. So I went ahead and swapped out the library, and finally the project can be build without any issues.

## Build settings

* iOS SDK version : 8.3
* iOS Deployment target : 7.1
* Supports iPod: Yes
* Supports iPhone (4/5/6/6+): Yes
* Supports iPad: Yes

## Important

The actual MobileVLCKit.framework file is not included in this repo, as it is about 600-700++ MB in size. You can follow the instructions [here](https://wiki.videolan.org/VLCKit/#Building_the_framework_for_iOS) to build the framework file, or download the pre-build binary from [here](http://nightlies.videolan.org/build/ios/).

