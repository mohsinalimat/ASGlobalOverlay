# ASGlobalOverlay

### A modern pop-over controller that's easy to implement.

## Description

ASGlobalOverlay is a pop-over controller that can display alerts, slide-up menus, and is-working indicators on top of your app. It features a modern interface and easy implementation.

## About

ASGlobalOverlay started off as part of a specific project. Unable to configure UIAlertController to match the modern look and feel of the project, I decided to make a custom replacement. Now, I'm open sourcing the project as ASGlobalOverlay.

That said, this is just the first pass. There is a lot of work to be done to make it a great library. I have a set of planned features listed below, and I'm interested in getting feedback on what developers would like to see.

## Installation

Install using [CocoaPods](http://cocoapods.org):

````ruby
pod 'ASGlobalOverlay'
````
Setup in app delegate:

```objective-c
#import <ASGlobalOverlay/ASGlobalOverlay.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    [ASGlobalOverlay setupGlobalOverlay];

    return YES;
}
```

That's it! You're up and running.

## Usage

_Be sure to check out the example app! It has a bunch of examples and helpful inline notes!_

_Also checkout the `ASGlobalOverlay` header and the `ASUserOption` header for helpful documentation._

If you just need a quick start, here are some basic usage examples to reference:

```objective-c

- (void)showAlert{

    ASUserOption * add = [ASUserOption userOptionWithTitle:@"Add" actionBlock:^{NSLog(@"'Add' pressed]");}];
    ASUserOption * cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];

    [ASGlobalOverlay showAlertWithTitle:@"Add Friend" message:@"Are you sure you want add this friend?" userOptions:@[add, cancel]];
}

- (void)showSlideUpMenu{

    ASUserOption * delete = [ASUserOption destructiveUserOptionWithTitle:@"Delete" actionBlock:^{NSLog(@"'Delete' pressed");}];
    ASUserOption * cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];

    [ASGlobalOverlay showSlideUpMenuWithPrompt:@"Are you sure you want to delete this post?" userOptions:@[delete, cancel]];
}

- (void)showWorkingIndicator{

    [ASGlobalOverlay showWorkingIndicatorWithDescription:@"Loading"];
}

- (void)dismissAlert{

    [ASGlobalOverlay dismissAlert];
}

- (void)dismissSlideUpMenu{

    [ASGlobalOverlay dismissSlideUpMenu];
}

- (void)dismissWorkingIndicator{

    [ASGlobalOverlay dismissWorkingIndicator];
}

```

Note: If you would like to smoothly transition between a visible popover and a new popover, simply call the show method for the new popover. `ASGlobalOverlay` will smoothly transition the first popover out. You can also do this from inside an `actionBlock`.

## Behavior & Implementation Notes

- ASGlobalOverlay will not appear over (or disable) a keyboard. It is recommended that you dismiss the keyboard before showing something with ASGlobalOverlay. Check out the example app for details.

- ASGlobalOverlay methods that show or dismiss views should only be called on the main thread.

- It is not recommended that you use ASGlobalOverlay and SVProgressHUD together (see 'Acknowledgements' below for details).

## Planned Features

* Progress bar pop-over
* Customizable colors via UIAppearance
* Customizable font
* Dynamic font support
* Automatic main-thread grabbing

*Planned features are subject to change.*

## Requirements

- iOS 8.0+
- ARC

## Author

Amit Sharma
amitsharma@mac.com

## License

ASGlobalOverlay is available under the MIT license. See the LICENSE file for more info.

## Acknowledgements

ASGlobalOverlay was inspired by [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD). Furthermore, the high-level architecture of this library (and one specific method) is largely based on the SVProgressHUD code. The SVProgressHUD contributors have put together a great library, and deserve major kudos for their work.

Since ASGlobalOverlay and SVProgressHUD both utilize the same code to position themselves in the view hierarchy, it is not recommended that you use them together.