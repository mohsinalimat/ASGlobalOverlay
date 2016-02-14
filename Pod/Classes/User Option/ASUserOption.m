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

#import "ASUserOption.h"

@interface ASUserOption ()

@property (nonatomic, strong, readwrite) NSString *actionTitle;
@property (nonatomic, copy, readwrite) ASUserAction actionBlock;
@property (nonatomic, readwrite) BOOL isDestructiveAction;
@property (nonatomic, readwrite) BOOL isCancelAction;
@end

@implementation ASUserOption

+ (instancetype)userOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock{
    
    ASUserOption *userOption = [[ASUserOption alloc] initWithTitle:title actionBlock:actionBlock];
    
    return userOption;
}

+ (instancetype)destructiveUserOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock{
    
    ASUserOption *userOption = [[ASUserOption alloc] initWithTitle:title actionBlock:actionBlock];
    userOption.isDestructiveAction = YES;
    
    return userOption;
}

+ (instancetype)cancelUserOptionWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock{
    
    ASUserOption *userOption = [[ASUserOption alloc] initWithTitle:title actionBlock:actionBlock];
    userOption.isCancelAction = YES;
    
    return userOption;
}

- (instancetype)initWithTitle:(NSString*)title actionBlock:(ASUserAction)actionBlock{
    
    self = [super init];
    
    self.actionTitle = title;
    self.actionBlock = actionBlock;
    self.isDestructiveAction = NO;
    self.isCancelAction = NO;
    
    return self;
}

@end
