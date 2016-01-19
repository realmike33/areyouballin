//
//  Clothing.h
//  AreYouBallin
//
//  Created by Michael Moss on 11/22/15.
//  Copyright © 2015 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clothing : NSObject
@property NSString *name;
@property NSString *itemDescription;
@property NSString *imgUrl;
@property NSURL *webUrl;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(void)getImageWithCompletion:(void(^)(NSData *))complete;
@end
