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

#import "ASExampleController.h"
#import <ASGlobalOverlay/ASGlobalOverlay.h>

@interface ASExampleController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic) BOOL shouldAutoDismissKeyboard;

@end

@implementation ASExampleController


#pragma mark - Keyboard Handling

/*
 *
 * ASGlobalOverlay will not appear over (or disable) a visible keyboard.
 * It is recommend that you dismiss the keyboard before you show any popover.
 *
 * That said, ASGlobalOverlay does dynamically move around the keyboard well.
 * Toggle the switch in the example app to try out the behavior either way.
 *
 */

- (IBAction)toggleSwitch:(id)sender {

    UISwitch *dismissSwitch = (UISwitch *)sender;
    _shouldAutoDismissKeyboard = dismissSwitch.isOn;
}

- (void)dismissKeyboard{
    
    if ([_textField isFirstResponder] && _shouldAutoDismissKeyboard) [_textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
        
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Alert View

- (IBAction)showAlertNoMessageOrOptions:(id)sender {
    
    [self dismissKeyboard];
    
    [ASGlobalOverlay showAlertWithTitle:@"Robot Attack!" message:nil forTimePeriod:2.0];
}

- (IBAction)showAlertNoOptions:(id)sender {
    
    [self dismissKeyboard];
    
    [ASGlobalOverlay showAlertWithTitle:@"Robots are Attacking!" message:@"We probably should have treated our computers betters." forTimePeriod:4.0f];
}

- (IBAction)showAlertOneOptions:(id)sender {
    
    [self dismissKeyboard];

    ASUserOption *ok = [ASUserOption userOptionWithTitle:@"OK" actionBlock:^{NSLog(@"'OK' pressed");}];
    
    [ASGlobalOverlay showAlertWithTitle:@"Robot are Attacking!" message:@"We probably should have treated our computers betters." userOptions:@[ok]];
}

- (IBAction)showAlertTwoOptionsSmall:(id)sender {
    
    [self dismissKeyboard];

    ASUserOption *add = [ASUserOption userOptionWithTitle:@"Add" actionBlock:^{NSLog(@"'Add' pressed]");}];
    ASUserOption *cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];
    
    [ASGlobalOverlay showAlertWithTitle:@"Add Friend" message:@"Are you sure you want add this friend?" userOptions:@[add, cancel]];
}

- (IBAction)showAlertMultiLineOptions:(id)sender {
    
    [self dismissKeyboard];

    ASUserOption *understands = [ASUserOption userOptionWithTitle:@"Yes, I Understand" actionBlock:^{NSLog(@"The user understands the situation");}];
    ASUserOption *doesNotUnderstand = [ASUserOption userOptionWithTitle:@"No" actionBlock:^{NSLog(@"The user is confused");}];
    
    [ASGlobalOverlay showAlertWithTitle:@"The Robot are Attacking!" message:@"This is a bad situation. Do you understand how bad this is?" userOptions:@[understands, doesNotUnderstand]];
}

#pragma mark - Slide Up Menu

- (IBAction)showSlideUpMenu:(id)sender {
    
    [self dismissKeyboard];

    ASUserOption *copy = [ASUserOption userOptionWithTitle:@"Copy Link" actionBlock:^{NSLog(@"'Copy Link' pressed");}];
    ASUserOption *email = [ASUserOption userOptionWithTitle:@"Share via Email" actionBlock:^{NSLog(@"'Share via Email' pressed");}];
    ASUserOption *safari = [ASUserOption userOptionWithTitle:@"Open in Safari" actionBlock:^{NSLog(@"'Open in Safari' pressed");}];
    ASUserOption *cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];
    
    [ASGlobalOverlay showSlideUpMenuWithPrompt:@"Please make a selection from the following options." userOptions:@[copy, email, safari, cancel]];
}

- (IBAction)showSlideUpMenuWithDestructiveOption:(id)sender {
    
    ASUserOption *delete = [ASUserOption destructiveUserOptionWithTitle:@"Delete" actionBlock:^{NSLog(@"'Delete' pressed");}];
    ASUserOption *cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];
    
    [ASGlobalOverlay showSlideUpMenuWithPrompt:@"Are you sure you want to delete this post?" userOptions:@[delete, cancel]];
}

#pragma mark - Working Indicator

- (IBAction)showWorkingIndicator:(id)sender {
    
    [self dismissKeyboard];

    [ASGlobalOverlay showWorkingIndicatorWithDescription:nil forTimePeriod:2.0f];
}

- (IBAction)showWorkingIndicatorWithPrompt:(id)sender {
    
    [self dismissKeyboard];

    [ASGlobalOverlay showWorkingIndicatorWithDescription:@"Loading" forTimePeriod:3.0];
}

#pragma mark - Combinations

- (IBAction)workingIndicatorThenAlert:(id)sender {
    
    [self dismissKeyboard];

    [ASGlobalOverlay showWorkingIndicatorWithDescription:@"Processing Payment..."];
    
    [self performSelector:@selector(showPaymentSuccessAlert) withObject:nil afterDelay:2.0f];
}

-(void)showPaymentSuccessAlert{
    
    [self dismissKeyboard];

    [ASGlobalOverlay showAlertWithTitle:@"Payment Processed!" message:@"Thank you for shopping" forTimePeriod:3.0];
}

- (IBAction)showSlideUpMenuThenWorkingIndicatorThenAlert:(id)sender {
    
    [self dismissKeyboard];

    ASUserOption *delete = [ASUserOption destructiveUserOptionWithTitle:@"Delete" actionBlock:^{
        
        // for seamless transitions between views, call for additional pop-ups to be shown within the action block
        [self showWorkingIndicatorThenSuccessIndicator];
    }];
    
    ASUserOption *cancel = [ASUserOption cancelUserOptionWithTitle:@"Cancel" actionBlock:^{NSLog(@"'Cancel' pressed");}];
    
    [ASGlobalOverlay showSlideUpMenuWithPrompt:@"For the purpose of this demo, select 'Delete.'" userOptions:@[delete, cancel]];
}

-(void)showWorkingIndicatorThenSuccessIndicator{
    
    [self dismissKeyboard];

    [self workingIndicatorThenAlert:nil];
}

@end
