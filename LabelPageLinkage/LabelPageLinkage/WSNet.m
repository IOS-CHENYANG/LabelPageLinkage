//
//  WSNet.m
//  WecastStatistics
//
//  Created by 陈阳阳 on 2017/5/8.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "WSNet.h"

typedef NS_ENUM(NSInteger,RequestMethod) {
    GET,
    POST
};

@interface WSNet ()

@property (nonatomic,strong) NSURLSession *session;

@end

@implementation WSNet

static WSNet *instance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = @{
                                                       @"Content-Type"  : @"application/json"
                                                       };
        
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return self;
}

+ (NSURLSessionTask *)httpGet:(NSString *)url params:(NSDictionary *)params success:(requestSuccess)success failure:(requestFailure)failure {
    return [[WSNet sharedInstance] requestWithUrl:url requestMethod:GET requestParams:params requestSuccess:success requestFailure:failure];
}

+ (NSURLSessionTask *)httpPost:(NSString *)url params:(NSDictionary *)params success:(requestSuccess)success failure:(requestFailure)failure {
    return [[WSNet sharedInstance] requestWithUrl:url requestMethod:POST requestParams:params requestSuccess:success requestFailure:failure];
}

- (NSURLSessionTask *)requestWithUrl:(NSString *)url requestMethod:(RequestMethod)method requestParams:(NSDictionary *)params requestSuccess:(requestSuccess)success requestFailure:(requestFailure)failure {
    
    NSURL *requestUrl = nil;
    NSMutableURLRequest *request = nil;
    switch (method) {
        case GET:
        {
            NSString *paramStr = [self paramStr:params];
            NSString *urlStr = paramStr.length == 0 ? url : [NSString stringWithFormat:@"%@?%@",url,paramStr];
            requestUrl = [NSURL URLWithString:urlStr];
            request = [NSMutableURLRequest requestWithURL:requestUrl];
            [request setHTTPMethod:@"GET"];
        }
            break;
        case POST:
        {
            requestUrl = [NSURL URLWithString:url];
            request = [NSMutableURLRequest requestWithURL:requestUrl];
            [request setHTTPMethod:@"POST"];
            NSError *error = nil;
            NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
            request.HTTPBody = paramsData;
        }
            break;
        default:
            break;
    }
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            success(responseData);
        });
    }];
    [task resume];
    return task;
}

- (NSString *)paramStr:(NSDictionary *)params {
    NSMutableString *paramStr = [NSMutableString string];
    __block BOOL first = YES;
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyvalue;
        if (first == YES)
        {
            keyvalue = [NSString stringWithFormat:@"%@=%@",key,obj];
            first = NO;
        }
        else
        {
            keyvalue = [NSString stringWithFormat:@"&%@=%@",key,obj];
        }
        [paramStr appendString:keyvalue];
    }];
    return paramStr;
}

@end
