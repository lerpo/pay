//
//  ViewController.m
//  Pay
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayViewController.h"
#import "CountListViewController.h"
#import "THDatePickerViewController.h"
#import "AreaSelectorViewController.h"
#import "AppUtil.h"
#import "BankCountModel.h"
#import "MoneyModel.h"
@interface PayViewController () <THDatePickerDelegate,CountListViewDelegate,UITextFieldDelegate>

@end

@implementation PayViewController

-(MoneyModel *)moneyModel{
    if(_moneyModel == nil){
        _moneyModel = [[MoneyModel alloc] init];
    }
    return _moneyModel;
}

-(UIScrollView *)scrollView{
    if(_scrollView == nil){
       _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.contentSize = CGSizeMake(kFrameWidth, kFrameHeight*1.2);
        _scrollView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];;
        [_scrollView addSubview:[[[NSBundle mainBundle] loadNibNamed:@"PayMoneyView" owner:self options:nil] firstObject]];
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarColor];
    self.title = @"转账";
    [self.view addSubview:self.scrollView] ;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addressCallBack:) name:@"address"object:nil];
    self.actExpectedCashText.userInteractionEnabled = NO;
    self.actMatchingBillText.userInteractionEnabled = NO;
    [self addObserver];
    [self setDelegate];
    }

-(void)addObserver{
    [self.moneyModel addObserver:self forKeyPath:EXPECTEDCASH options:NSKeyValueObservingOptionNew context:nil];
    [self.moneyModel addObserver:self forKeyPath:EXPECTEDdBILL options:NSKeyValueObservingOptionNew context:nil];
    [self.moneyModel addObserver:self forKeyPath:MATCHINGCASH options:NSKeyValueObservingOptionNew context:nil];
    [self.moneyModel addObserver:self forKeyPath:MATCHINGBILL options:NSKeyValueObservingOptionNew context:nil];
    

}

-(void)setBarColor{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:167.0/255.0 green:16.0/255.0 blue:2.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

}

-(void)setDelegate{
    self.expectedCashText.delegate = self;
    self.expectedCashText.tag = expectedCashText;
    
    self.expectedBillText.delegate = self;
    self.expectedBillText.tag = expectedBillText;
    
    self.matchingBillText.delegate = self;
    self.matchingBillText.tag = matchingBillText;
    
    self.matchingCashText.delegate = self;
    self.matchingCashText.tag = matchingCashText;
}
- (IBAction)selectDate:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = [NSDate date];
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setAutoCloseOnSelectDate:YES];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        if(tmp % 5 == 0)
            return YES;
        return NO;
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.3),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];

    
}
/*
 * 选择付款账户
 */
- (IBAction)selectAcount:(id)sender {
    [self.navigationController pushViewController:[self CountListControllerWithType:PAYACOUNT] animated:YES];
}


- (IBAction)countsSelect:(id)sender {
   [self.navigationController pushViewController:[self CountListControllerWithType:RECIEVEACOUT] animated:YES];
}

- (IBAction)bankSelect:(id)sender {
    [self.navigationController pushViewController:[self CountListControllerWithType:RECIEVEBANK] animated:YES];
}


/**
 *  期望现金比例增减
 *  期望票据比例增减
 */
- (IBAction)creamentButtonClick:(UIButton *)sender {
    NSInteger index = sender.tag;
    switch (index) {
        case 0:{
           float expectedCash = [self.moneyModel.expectedCash floatValue];
            expectedCash++;
           self.moneyModel.expectedCash = [NSString stringWithFormat:@"%0.2f",expectedCash];
            
        }
            break;
        case 1:{
            float expectedCash = [self.moneyModel.expectedCash floatValue];
            if(expectedCash > 0){
            expectedCash--;
            self.moneyModel.expectedCash = [NSString stringWithFormat:@"%0.2f",expectedCash];
            }
        }
            break;
            
        case 2:{
             float expectedBill = [self.moneyModel.expectedBill floatValue];
             expectedBill++;
             self.moneyModel.expectedBill = [NSString stringWithFormat:@"%0.2f",expectedBill];

        }
            break;
        case 3:{
            float expectedBill = [self.moneyModel.expectedBill floatValue];
            if(expectedBill > 0){
            expectedBill--;
            self.moneyModel.expectedBill = [NSString stringWithFormat:@"%0.2f",expectedBill];
            }
        }
            break;
        
    }
    
}



- (CountListViewController *)CountListControllerWithType:(int)type{
    CountListViewController *ctr = [[CountListViewController alloc]init] ;
    ctr.type = type;
    ctr.delegate = self;
    
    return ctr;

}

/**
 *  地区选择
 */
- (IBAction)areaSelect:(id)sender {
    AreaSelectorViewController *controller = [[AreaSelectorViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}



-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker{
  
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *stringDate = [formatter stringFromDate:datePicker.date];
    [self.dateSelect setTitle:stringDate forState:UIControlStateNormal];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker{
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

-(void)addressCallBack:(NSNotification *)notification
{
    NSString *address = notification.object;
    if(address != nil){
        [self.address setTitle:address forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


// 当输入框获得焦点时
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

// 文本框的文本，是否能被修改
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
    
}
// 文本框失去first responder 时，执行
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    switch (textField.tag) {
        case expectedCashText:
        {
            self.moneyModel.expectedCash = text;
        }
            break;
            
        case expectedBillText:
        {
            self.moneyModel.expectedBill = text;
        }
            break;
        case matchingCashText:{
            if(self.moneyModel.expectedCash != nil && self.moneyModel.expectedBill != nil && text!= nil && self.moneyModel.matchingBill == nil){
                self.moneyModel.matchingCash = text;

                float expectCach = [self.moneyModel.expectedCash floatValue];
                float expectBill = [self.moneyModel.expectedBill floatValue];
                float matchCash = [self.moneyModel.matchingCash floatValue];
                float matchBill = matchCash/expectCach*expectBill;
                self.moneyModel.matchingBill = [NSString stringWithFormat:@"%0.2f",matchBill];
            }
            if(text != nil && self.moneyModel.matchingBill != nil){
                self.moneyModel.matchingCash = text;

                float matchCash = [self.moneyModel.matchingCash floatValue];
                float matchBill = [self.moneyModel.matchingBill floatValue];
                
                float actMatchCash = (matchCash/(matchCash+matchBill))*100;
                float actMatchBill = (matchBill/(matchCash+matchBill))*100;
                self.moneyModel.actExpectedCash = [NSString stringWithFormat:@"%0.0f",actMatchCash];
                self.moneyModel.actMatchingBill = [NSString stringWithFormat:@"%0.0f",actMatchBill];
            }
            if(text != nil){
                self.moneyModel.matchingCash = text;
            }
        }
            break;
        case matchingBillText:{
            
            if(self.moneyModel.matchingCash != nil && text != nil){
                self.moneyModel.matchingBill = text;
                float matchCash = [self.moneyModel.matchingCash floatValue];
                float matchBill = [self.moneyModel.matchingBill floatValue];
                float actMatchCash = (matchCash/(matchCash+matchBill))*100;
                float actMatchBill = (matchBill/(matchCash+matchBill))*100;
                self.moneyModel.actExpectedCash = [NSString stringWithFormat:@"%0.0f",actMatchCash];
                self.moneyModel.actMatchingBill = [NSString stringWithFormat:@"%0.0f",actMatchBill];


            }
            if(text != nil){
                self.moneyModel.matchingBill = text;
            }
        }
            break;
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    MoneyModel *model = (MoneyModel *)object;
    if([keyPath isEqualToString:EXPECTEDCASH]){
        self.expectedCashText.text = model.expectedCash;
    }
    if([keyPath isEqualToString:EXPECTEDdBILL]){
        self.expectedBillText.text = model.expectedBill;
    }
    if([keyPath isEqualToString:MATCHINGCASH]){
        self.matchingCashText.text = model.matchingCash;
        self.actExpectedCashText.text = model.actExpectedCash;
        self.actMatchingBillText.text = model.actMatchingBill;
    }
    if([keyPath isEqualToString:MATCHINGBILL]){
        self.matchingBillText.text = model.matchingBill;
        self.actExpectedCashText.text = model.actExpectedCash;
        self.actMatchingBillText.text = model.actMatchingBill;
    }
    
    
}
-(void)callBackModel:(BankCountModel *)model type:(int)type{
    switch (type) {
        case PAYACOUNT:
        {
            [self.payAcount setTitle:model.bankName forState:UIControlStateNormal];
        }
            break;
            
        case RECIEVEACOUT:
        {
            self.reciverName.text = model.name;
            [self.reciveBank setTitle:model.bankName forState:UIControlStateNormal];
            [self.address setTitle:model.address forState:UIControlStateNormal];
        }
            break;
        case RECIEVEBANK:
        {
            [self.reciveBank setTitle:model.bankName forState:UIControlStateNormal];
        }
            break;
    }
}


@end
