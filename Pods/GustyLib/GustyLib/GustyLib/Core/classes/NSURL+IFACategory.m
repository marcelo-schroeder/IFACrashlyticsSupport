//
// Created by Marcelo Schroeder on 30/04/2014.
// Copyright (c) 2014 InfoAccent Pty Ltd. All rights reserved.
//

#import "NSURL+IFACategory.h"


@implementation NSURL (IFACategory)

#pragma mark - Public

- (BOOL)ifa_isAppleUrlScheme {
    if (
            [self.scheme isEqualToString:@"mailto"]
                    || [self.scheme isEqualToString:@"tel"]
                    || [self.scheme isEqualToString:@"facetime"]
                    || [self.scheme isEqualToString:@"sms"]
            ) {
        return YES;
    } else {
        return NO;
    }
}

@end