//
//  MoneyModel.h
//  Pay
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyModel : NSObject

@property (strong, nonatomic) NSString  *expectedCash;       //期望现金比例

@property (strong, nonatomic) NSString  *expectedBill;       //期望票据比例

@property (strong, nonatomic) NSString  *matchingCash;       //匹配现金

@property (strong, nonatomic) NSString  *matchingBill;       //匹配票据

@property (strong, nonatomic) NSString  *actExpectedCash;    //实际现金比例

@property (strong, nonatomic) NSString  *actMatchingBill;    //实际票据比例

@end
