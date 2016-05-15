//
//  Steper.h
//  Pay
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Steper;
// called when value is changed
typedef void (^StepperValueChangedCallback)(Steper *stepper, float newValue);

// called when value is incremented
typedef void (^StepperIncrementedCallback)(Steper *stepper, float newValue);


// called when value is decremented
typedef void (^StepperDecrementedCallback)(Steper *stepper, float newValue);

IB_DESIGNABLE
@interface Steper : UIView

@property(nonatomic, strong) UITextField *countLabel;
@property(nonatomic, strong) UIColor *labelColor;
@property(nonatomic, strong) UIButton *incrementButton;
@property(nonatomic, strong) UIButton *decrementButton;

@property(nonatomic) float value; // default: 0.0
@property(nonatomic) float stepInterval; // default: 1.0
@property(nonatomic) float minimum; // default: 0.0
@property(nonatomic) float maximum; // default: 100.0
@property(nonatomic) BOOL hidesDecrementWhenMinimum; // default: NO
@property(nonatomic) BOOL hidesIncrementWhenMaximum; // default: NO
@property(nonatomic) CGFloat buttonWidth; // default: 44.0f

@property(nonatomic, copy) StepperValueChangedCallback valueChangedCallback;
@property(nonatomic, copy) StepperIncrementedCallback incrementCallback;
@property(nonatomic, copy) StepperDecrementedCallback decrementCallback;

// call this method after setting value(s) and callback(s)
// This method will call callback
- (void)setup;

// view customization
- (void)setBorderColor:(UIColor *)color;
- (void)setBorderWidth:(CGFloat)width;
- (void)setCornerRadius:(CGFloat)radius;

- (void)setLabelTextColor:(UIColor *)color;
- (void)setLabelFont:(UIFont *)font;

- (void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state;
- (void)setButtonFont:(UIFont *)font;
@end
