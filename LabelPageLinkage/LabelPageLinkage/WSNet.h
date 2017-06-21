//
//  WSNet.h
//  WecastStatistics
//
//  Created by 陈阳阳 on 2017/5/8.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requestSuccess) (id responseData);
typedef void (^requestFailure) (NSInteger code,NSError *error);

@interface WSNet : NSObject

+ (NSURLSessionTask *)httpGet:(NSString *)url
                   params:(NSDictionary *)params
                  success:(requestSuccess)success
                  failure:(requestFailure)failure;

+ (NSURLSessionTask *)httpPost:(NSString *)url
                    params:(NSDictionary *)params
                   success:(requestSuccess)success
                   failure:(requestFailure)failure;

@end
