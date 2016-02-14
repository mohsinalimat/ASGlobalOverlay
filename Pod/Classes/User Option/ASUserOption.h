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
// THE SOFTWARE

#import <Foundation/Foundation.h>

typedef void (^ASUserAction)(void);

/**
 *
 * An ASUserOption object represents an action that the user can make, which will be presented to the user as a button.
 * The object contains an actionTitle, which is used as the button title, and an actionBlock, which is invoked when the button is pressed.
 * Additionally, ASUserOption contains flags to indicate if the button is destructive, or if it is a cancel button. Theses flags only affect the button's text color.
 *
 * The buttons may be presented to the user in different ways.
 * See the ASGlobalOverlay header for details.
 *
 * @see ASGlobalOverlay
 *
 */

@interface ASUserOption : NSObject

/**
 *
 * The title of the option. Is used as the title of the user action button.
 *
 */

@property (nonatomic, strong, readonly) NSString *actionTitle;

/**
 *
 * A block that is invoked after the user presses the user action button.
 *
 * The view that is displaying the button will automatically be dismissed after this block is invoked.
 *
 * If you would like to seamlessly transition to showing another ASGlobalOverlay view, make the call to show the new view inside this block.
 * For example, you could show a "Add friend?" alert confirming that the user would like to add a friend...
 * (cont.) followed by a working indicator, and finally another alert confirm that the friend was added successfully.
 *
 * The currently showing ASGlobalOverlay view will automatically be dismissed after this block is invoked.
 *
 */

@property (nonatomic, copy, readonly) ASUserAction actionBlock;

/**
 *
 * If true, the text color of the user action will be set to a shade of red, indicating to the user that the button does something destructive.
 *
 */

@property (nonatomic, readonly) BOOL isDestructiveAction;

/**
 *
 * If true, the text color of the user action will be set to a light shade of grey, indicating to the user that the button does nothing.
 *
 */

@property (nonatomic, readonly) BOOL isCancelAction;

/**
 *
 * Returns an ASUserAction with a given title and actionBlock.
 *
 */

+ (instancetype)userOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock;

/**
 *
 * Returns an ASUserAction with a given title and actionBlock that has been flagged as destructive, resulting in a red button title.
 *
 */

+ (instancetype)destructiveUserOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock;

/**
 *
 * Returns an ASUserAction with a given title and actionBlock that has been flagged as a cancel button, resulting in a light grey button title.
 *
 */

+ (instancetype)cancelUserOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock;

@end
