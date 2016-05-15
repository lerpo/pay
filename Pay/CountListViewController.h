//
//  CountListViewController.h
//  Pay
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCountModel;
@protocol CountListViewDelegate <NSObject>

-(void)callBackModel:(BankCountModel *)model type:(int)type;

@end

@interface CountListViewController : UIViewController

@property(nonatomic,assign) int type;
@property(nonatomic,strong) id<CountListViewDelegate> delegate;
@end
