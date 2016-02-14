//
// ASGlobalOverlay
//
// Copyright (c) 2015 Amit Sharma <amitsharma@mac.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIKit.h>
#import "ASGlobalOverlay.h"
#import "ASUserOption.h"

// ================
// ASGlobalOverlay
// ================

/**
 *
 * ASGlobalOverlay is a 'pop-over' controller that can display alerts, slide-up menus, and working indicators on top of your app.
 *
 * ## Setup
 *
 * ASGlobalOverlay should not be directly initialized.
 * Instead, call +setupGlobalOverlay on ASGlobalOverlay in application:didFinishLaunchingWithOptions:, then utilize the class methods on ASGlobalOverlay from anywhere in your app.
 *
 * ## Implementation & Behavior Details
 *
 * - ASGlobalOverlay will not appear over (or disable) a keyboard.
 * - It is recommended that you dismiss the keyboard before showing something with ASGlobalOverlay. Check out the example app for details.
 * - ASGlobalOverlay methods that show or dismiss views should only be called on the main thread.
 *
 * ## Learn More
 *
 * Please reference the README on GitHub for additional detail.
 * URL GOES HERE
 *
 * ## Acknowledgements
 *
 * ASGlobalOverlay was inspired by the SVProgressHUD library.
 * Furthermore, the high-level architecture of this library (and one specific method) is largely based on the SVProgressHUD code.
 * The SVProgressHUD contributors have put together a great library, and deserve major kudos for their work.
 * (https://github.com/SVProgressHUD/SVProgressHUD)
 *
 * On a related note, since ASGlobalOverlay and SVProgressHUD both utilize the same code to position themselves in the view hierarchy, it is not recommended that you use them together.
 *
 */

@interface ASGlobalOverlay : NSObject

- (instancetype)init NS_UNAVAILABLE;

// ======
// Setup
// ======

/**
 *
 * Ensures that the internal ASGlobalOverlay singleton is initialized and tracking the state of the keyboard.
 *
 * It is recommended that you call this method in application:didFinishLaunchingWithOptions: to ensure that the internal keyboard-state tracking is accurate.
 *
 */

+ (void)setupGlobalOverlay;

// =======
// Alerts
// =======

/**
 *
 * Shows an alert that is visually similar to an alert-style UIAlertController.
 *
 * Calling this method will immediately dismiss any other view that is being shown by the ASGlobalOverlay.
 * This includes views that were to be dismissed after a given time delay.
 *
 * @param title Nullable. The title of the alert. The title is restricted to a single line. Specifying nil defaults the title to 'Alert'.
 *
 * @param message Nullable. A message describing the alert. Messages longer than 8 lines will be truncated.
 *
 * @param userOptions Nullable. An array of ASUserOption(s). Each option will be represented as a button. A maximum of 8 options will be shown.
 *
 * The alert will automatically be dismissed after a button is pressed and the ASUserOption actionBlock is invoked (if any).
 *
 * If no options are provided, the alert will need be to dismissed manually .
 * If you are not including any options, you may want to consider using showAlertWithTitle:message:forTimePeriod:.
 * See the ASGlobalOverlay header for additional options.
 *
 * @see ASUserOption
 *
 */

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message userOptions:(NSArray *)userOptions;

/**
 *
 * Shows an alert that is visually similar to an alert-style UIAlertController.
 *
 * Calling this method will immediately dismiss any other view that is being shown by the ASGlobalOverlay.
 * This includes views that were to be dismissed after a given time delay.
 *
 * @param title Nullable. The title of the alert. The title is restricted to a single line. Specifying nil defaults the title to 'Alert'.
 *
 * @param message Nullable. A message describing the alert. Messages longer than 8 lines will be truncated.
 *
 * @param displayTime Nullable. The amount of time that the alert will be displayed before it is automatically dismissed (in seconds).
 *
 */

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message forTimePeriod:(NSTimeInterval)displayTime;

/**
 *
 * Sets a timer that will dismiss the alert that is currently showing upon firing.
 *
 * @param delay the amount of time that the alert will be displayed before it is
 *
 * @warning If no alert is being shown, this method will do nothing.
 *
 */

+ (void)dismissAlertWithDelay:(NSTimeInterval)delay;

/**
 *
 * Immediately dismisses the alert that is currently showing and stops all dismissal timers. Does nothing if an alert is not currently showing.
 *
 */

+ (void)dismissAlert;

// ==============
// Slide Up Menus
// ==============

/**
 *
 * Shows an slide up menu that is visually similar to an action-sheet-style UIAlertController.
 *
 * Calling this method will immediately dismiss any other view that is being shown by the ASGlobalOverlay.
 * This includes views that were to be dismissed after a given time delay.
 *
 * @param prompt Nullable. A description of available options. Prompts longer than 8 lines will be truncated.
 *
 * @param message Nullable. A message describing the alert. Messages longer than 8 lines will be truncated.
 *
 * @param userOptions Required. An array of ASUserOption(s). Each option will be represented as a button. A maximum of 8 options will be shown.
 *
 * The slide up will automatically be dismissed after a button is pressed and the ASUserOption actionBlock is invoked (if any).
 *
 * @warning nothing will happen if there are no user options.
 *
 * @see ASUserOption
 *
 */

+ (void)showSlideUpMenuWithPrompt:(NSString *)prompt userOptions:(NSArray *)userOptions;

/**
 *
 * Immediately dismisses the slide up menu that is currently showing and stops all dismissal timers. Does nothing if a slide up menu is not currently showing.
 *
 */

+ (void)dismissSlideUpMenu;

// ==================
// Working Indicators
// ==================

/**
 *
 * Shows an working indicator, which is comprised of a UIActivityIndicator centered in a light grey box, and an option label.
 *
 * Calling this method will immediately dismiss any other view that is being shown by the ASGlobalOverlay.
 * This includes views that were to be dismissed after a given time delay.
 *
 * @param description Nullable. A description of what work is being done. Limited to 1 line.
 *
 * The working indicators can be dismissed by calling +dismissWorkingIndicator or +dismissWorkingIndicatorWithDelay:.
 *
 * @see +showWorkingIndicatorWithDescription:forTimePeriod:.
 *
 */

+ (void)showWorkingIndicatorWithDescription:(NSString *)description;

/**
 *
 * Shows an working indicator, which is comprised of a UIActivityIndicator centered in a light grey box, and an option label.
 *
 * Calling this method will immediately dismiss any other view that is being shown by the ASGlobalOverlay.
 * This includes views that were to be dismissed after a given time delay.
 *
 * @param description Nullable. A description of what work is being done. Limited to 1 line.
 *
 * @param displayTime The amount of time that the working indicator should be displayed for before it is dismissed.
 *
 */

+ (void)showWorkingIndicatorWithDescription:(NSString *)description forTimePeriod:(NSTimeInterval)delay;

/**
 *
 * Sets a timer that will dismiss the working indicator that is currently showing upon firing.
 *
 * @param delayTime the amount of time that the working indicator will be displayed before it is
 *
 * @warning If no working indicator is being shown, this method will do nothing.
 *
 */

+ (void)dismissWorkingIndicatorWithDelay:(NSTimeInterval)delay;

/**
 *
 * Immediately dismisses the working indicator that is currently showing and stops all dismissal timers. Does nothing if a working indicator is not currently showing.
 *
 */

+ (void)dismissWorkingIndicator;

// ==============================
// Dismiss Everything Immediately
// ==============================

/**
 *
 * Immediately dismisses any visible popover view and the global overlay itself (if visible).
 * Also cancels any prior time-delayed dismissals and dismisses those views immediately.
 *
 */

+ (void)dismissEverythingImmediately;

// ==================
// Visibility Helpers
// ==================

/**
 *
 * Indicates if any ASGlobalOverlay view is being displayed.
 *
 */

+ (BOOL)isVisible;

/**
 *
 * Indicates if an alert is being displayed.
 *
 */

+ (BOOL)isShowingAlert;

/**
 *
 * Indicates if a slide up menu is being displayed.
 *
 */

+ (BOOL)isShowingSlideUpMenu;

/**
 *
 * Indicates if a working indicator is being displayed.
 *
 */

+ (BOOL)isShowingWorkingIndicator;

@end