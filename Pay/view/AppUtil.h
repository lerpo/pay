//
//  AppUtil.h
//  Pay
//
//  Created by apple on 16/5/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef AppUtil_h
#define AppUtil_h
#define kFrameWidth  self.view.frame.size.width
#define kFrameHeight self.view.frame.size.height

#define EXPECTEDCASH @"expectedCash"
#define EXPECTEDdBILL @"expectedBill"
#define MATCHINGCASH @"matchingCash"
#define MATCHINGBILL @"matchingBill"

typedef NS_ENUM(int,pagetype){
    PAYACOUNT,
    RECIEVEACOUT,
    RECIEVEBANK
};

typedef NS_ENUM(int,textflag) {
    expectedCashText,
    expectedBillText,
    matchingBillText,
    matchingCashText

};

#endif /* AppUtil_h */
