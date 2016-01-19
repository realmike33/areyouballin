//
//  Clothing.m
//  AreYouBallin
//
//  Created by Michael Moss on 11/22/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import "Clothing.h"

@implementation Clothing

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if(self){
        self.name = [dictionary objectForKey:@"name"];
        self.itemDescription = [dictionary objectForKey:@"description"];
        NSDictionary *imageObj = [dictionary objectForKey:@"image"];
        NSDictionary *sizes = [imageObj objectForKey:@"sizes"];
        NSDictionary *iphoneSize = [sizes objectForKey:@"IPhone"];
        self.imgUrl = [iphoneSize objectForKey:@"url"];
        self.webUrl = [NSURL URLWithString:@"pageUrl"];
    }
    return self;
}

-(void)getImageWithCompletion:(void(^)(NSData *))complete{
    NSURL *url = [NSURL URLWithString:self.imgUrl];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(data);
        });
    }];
    
    [task resume];
}

@end
