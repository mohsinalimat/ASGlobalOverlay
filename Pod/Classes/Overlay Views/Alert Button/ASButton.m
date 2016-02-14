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

#import "ASButton.h"

@interface ASButton ()

@property (strong, nonatomic) UIButton *button;

@property (strong, nonatomic) UIView *topBorderLine;
@property (strong, nonatomic) UIView *rightBorderLine;

@property (nonatomic) ASUserOption *userOption;

@property (nonatomic, weak) id<ASButtonDismissDelegate> delegate;

@end

@implementation ASButton

- (instancetype)initButtonViewWithUserAction:(ASUserOption *)userAction delegate:(id<ASButtonDismissDelegate>)delegate{
    
    self = [super init];
    
    _userOption = userAction;
    _delegate = delegate;
    self.backgroundColor = [UIColor clearColor];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:userAction.actionTitle forState:UIControlStateNormal];
    [_button setBackgroundColor:[UIColor clearColor]];
    [_button addTarget:self action:@selector(performUserActionBlockAndDismissAlert) forControlEvents:UIControlEventTouchUpInside];
    [self configureTextColor];
    [self addSubview:_button];
    
    _topBorderLine = [[UIView alloc] init];
    _topBorderLine.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    [self addSubview:_topBorderLine];
    
    _rightBorderLine = [[UIView alloc]init];
    _rightBorderLine.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
    _rightBorderLine.hidden = YES;
    [self addSubview:_rightBorderLine];

    return self;
}

- (void)configureTextColor{
    
    UIColor *textColor = [UIColor darkGrayColor];
    if (_userOption.isDestructiveAction) textColor = [UIColor colorWithRed:0.730f green:0.121f blue:0.130f alpha:1.00f];
    if (_userOption.isCancelAction) textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    [_button setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)performUserActionBlockAndDismissAlert{
    
    UIView *view = (UIView*)_delegate;
    if ([view respondsToSelector:@selector(setTag:)]) view.tag = kDoNotRemoveViewTag;
    if (_userOption.actionBlock) _userOption.actionBlock();
    [_delegate dismissView];
}

- (void)makeRightSideBorderHidden:(BOOL)hidden{
    
    _rightBorderLine.hidden = hidden;
}

#pragma mark - Layout

- (void)layoutSubviews{
    
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _topBorderLine.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    _rightBorderLine.frame = CGRectMake(self.frame.size.width - 0.5f, 0, 0.5f, self.frame.size.height);
}

- (CGFloat)widthOfButtonLabel{
    
    return [_button.titleLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
}

@end
