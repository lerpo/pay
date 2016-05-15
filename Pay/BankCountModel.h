//
//  BankCountModel.h
//  Pay
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCountModel : NSObject

@property(nonatomic,copy) NSString *bankLogo;
@property(nonatomic,copy) NSString *bankName;
@property(nonatomic,copy) NSString *countName;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *name;

+ (NSArray *)creatModelInType:(int)type;
@end
