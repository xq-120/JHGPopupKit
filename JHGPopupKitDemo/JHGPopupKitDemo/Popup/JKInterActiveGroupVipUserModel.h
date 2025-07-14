//
//  ZAEInterActiveGroupVipUserModel.h
//  JKPresentationControllerDemo
//
//  Created by uzzi on 2020/10/14.
//  Copyright © 2020 uzzi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKInterActiveGroupVipUserModel : NSObject

@property (nonatomic, assign) NSInteger userID; ///< 用户ID
@property (nonatomic, copy) NSString *nickname; ///< 昵称
@property (nonatomic, copy) NSString *avatar; ///< 头像

@end


NS_ASSUME_NONNULL_END
