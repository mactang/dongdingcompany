//
//  PersonInformationModel.h
//  Eoffice1.0
//
//  Created by gyz on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInformationModel : NSObject
@property (copy,nonatomic) NSString *CCustomerId;
@property (copy,nonatomic) NSString *adClientId;
@property (copy,nonatomic) NSString *adOrgId;
@property (copy,nonatomic) NSString *createdby;
@property (copy,nonatomic) NSString *updatedby;
@property (copy,nonatomic) NSString *created;
@property (copy,nonatomic) NSString *updated;
@property (copy,nonatomic) NSString *isactive;
@property (copy,nonatomic) NSString *WUserId;
@property (copy,nonatomic) NSString *CBpartnerId;
@property (copy,nonatomic) NSString *status;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *shorname;
@property (copy,nonatomic) NSString *username;
@property (copy,nonatomic) NSString *gender;
@property (copy,nonatomic) NSString *birthday;
@property (copy,nonatomic) NSString *idnumber;
@property (copy,nonatomic) NSString *qq;
@property (copy,nonatomic) NSString *tel;
@property (copy,nonatomic) NSString *phone;
@property (copy,nonatomic) NSString *email;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *value;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *Description;
@property (copy,nonatomic) NSString *iscustomer;
@property (copy,nonatomic) NSString *isvendor;





+(PersonInformationModel *)modelWithDic:(NSDictionary *)dic;
-(id)initWithDic:(NSDictionary *)dic;
@end
