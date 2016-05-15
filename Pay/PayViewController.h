//
//  ViewController.h
//  Pay
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THDatePickerViewController;
@class MoneyModel;
@interface PayViewController : UIViewController

@property (nonatomic ,strong) MoneyModel *moneyModel;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *dateSelect;
@property (weak, nonatomic) IBOutlet UIButton *address;
@property (weak, nonatomic) IBOutlet UIButton *selectReciveCount;
@property (weak, nonatomic) IBOutlet UITextField *reciverName;
@property (weak, nonatomic) IBOutlet UIButton *reciveBank;
@property (weak, nonatomic) IBOutlet UIButton *payAcount;

@property (weak, nonatomic) IBOutlet UITextField *expectedCashText;

@property (weak, nonatomic) IBOutlet UITextField *expectedBillText;

@property (weak, nonatomic) IBOutlet UITextField *matchingCashText;

@property (weak, nonatomic) IBOutlet UITextField *matchingBillText;

@property (weak, nonatomic) IBOutlet UITextField *actExpectedCashText;

@property (weak, nonatomic) IBOutlet UITextField *actMatchingBillText;


@end

