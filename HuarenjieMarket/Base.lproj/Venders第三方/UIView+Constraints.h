//
//  UIView+Constraints.h
//  JianGeSmartRemoter
//
//  Created by Smartios2012 on 15/7/7.
//  Copyright (c) 2015年 com.jiange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)leftConstraint;
- (NSLayoutConstraint *)rightConstraint;
- (NSLayoutConstraint *)topConstraint;
- (NSLayoutConstraint *)bottomConstraint;
- (NSLayoutConstraint *)leadingConstraint;
- (NSLayoutConstraint *)trailingConstraint;
- (NSLayoutConstraint *)widthConstraint;
- (NSLayoutConstraint *)heightConstraint;
- (NSLayoutConstraint *)centerXConstraint;
- (NSLayoutConstraint *)centerYConstraint;
- (NSLayoutConstraint *)baseLineConstraint;

@end
