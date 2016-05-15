//
//  BankCountModel.m
//  Pay
//
//  Created by apple on 16/5/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BankCountModel.h"
#import "AppUtil.h"
@implementation BankCountModel

+ (NSMutableArray *)creatModelInType:(int)type {
    NSMutableArray *array = [NSMutableArray array];
    switch (type) {
        case PAYACOUNT:
           {
               BankCountModel *model1= [[BankCountModel alloc] init];
               model1.bankLogo = @"bank_china";
               model1.bankName = @"中国银行";
               model1.countName = @"尾号8888";
               BankCountModel *model2= [[BankCountModel alloc] init];
               model2.bankLogo = @"bank_china";
               model2.bankName = @"中国工商银行";
               model2.countName = @"尾号8888";
               
               BankCountModel *model3= [[BankCountModel alloc] init];
               model3.bankLogo = @"bank_china";
               model3.bankName = @"中国建设银行";
               model3.countName = @"尾号8888";
               array = [NSMutableArray arrayWithObjects:model1,model2,model3,model1,model2,model3, nil];
           }
            break;
            
        case RECIEVEACOUT:
           {
               
               BankCountModel *model1= [[BankCountModel alloc] init];
               model1.bankLogo = @"bank_china";
               model1.bankName = @"中国银行";
               model1.countName = @"尾号9988";
               model1.address = @"上海市－徐汇区－徐家汇";
               model1.name = @"郑杰";
               BankCountModel *model2= [[BankCountModel alloc] init];
               model2.bankLogo = @"bank_china";
               model2.bankName = @"中国工商银行";
               model2.countName = @"尾号0000";
               model2.address = @"上海市－黄埔区－黄浦";
               model2.name = @"王珂";
               BankCountModel *model3= [[BankCountModel alloc] init];
               model3.bankLogo = @"bank_china";
               model3.bankName = @"民生银行";
               model3.countName = @"尾号3344";
               model3.address = @"上海市－虹口区－虹桥路";
               model3.name = @"高立仁";
               BankCountModel *model4= [[BankCountModel alloc] init];
               model4.bankLogo = @"bank_china";
               model4.bankName = @"浦发银行";
               model4.countName = @"尾号3366";
               model4.address = @"上海市－浦东区－浦东大道";
               model4.name = @"朱学礼";
               BankCountModel *model5= [[BankCountModel alloc] init];
               model5.bankLogo = @"bank_china";
               model5.bankName = @"南京银行";
               model5.countName = @"尾号8899";
               model5.address = @"上海市－金山区－金山路";
               model5.name = @"敏儿";
               for(int i = 0 ; i < 50; i++){
                  
                   [array addObject:model1];
                   [array addObject:model2];
                   [array addObject:model3];
                   [array addObject:model4];
                   [array addObject:model5];
               }
             
           }
            break;
        case RECIEVEBANK:
            {
                BankCountModel *model1= [[BankCountModel alloc] init];
                model1.bankLogo = @"bank_china";
                model1.bankName = @"中国银行";
                model1.countName = @"尾号8888";
                BankCountModel *model2= [[BankCountModel alloc] init];
                model2.bankLogo = @"bank_china";
                model2.bankName = @"中国工商银行";
                model2.countName = @"尾号8888";
                
                BankCountModel *model3= [[BankCountModel alloc] init];
                model3.bankLogo = @"bank_china";
                model3.bankName = @"中国建设银行";
                model3.countName = @"尾号8888";
                for(int i = 0 ; i < 50; i++){
                    
                    [array addObject:model1];
                    [array addObject:model2];
                    [array addObject:model3];
                }

            }
            break;
    }
    

    
    return array;

}
@end
