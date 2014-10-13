//
//  BaseEntity.h
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESS 0

@interface BaseEntity : NSObject

/**
 *  根据返回值解析对象
 *
 *  @param dict
 *
 *  @return
 */
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
/**
 *  根据返回值解析对象
 *
 *  @param dict
 *
 *  @return
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  根据对象生成字典
 *
 *
 *
 *  @return
 */
- (NSDictionary *)dictionaryRepresentation;

@end
