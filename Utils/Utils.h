//
//  Utils.h
//  Utils
//
//  Created by Mikhail Vroubel on 9/20/15.
//  Copyright © 2015 Mikhail Vroubel. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for Utils.
FOUNDATION_EXPORT double UtilsVersionNumber;

//! Project version string for Utils.
FOUNDATION_EXPORT const unsigned char UtilsVersionString[];

#import <Foundation/Foundation.h>

@interface Utils : NSObject
@end

@protocol Memoable<NSObject>
+ (NSString * _Nonnull)memoKey;
+ (instancetype _Nullable)memo:(NSString * _Nullable)name;
- (void)memo:( NSString * _Nullable)name;
@end

@protocol Setupable<NSObject>
+ (instancetype _Nonnull)setup:(void( ^ _Nullable )(_Nonnull id aSelf))setup;
- (instancetype _Nonnull)setup:(void( ^ _Nullable )(_Nonnull id aSelf))setup;
@end

@interface NSObject (Utils) <Memoable, Setupable>
@end
