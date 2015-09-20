//
//  NSObject+NextRun.m
//  Signal
//
//  Created by Mikhail Vroubel on 07/02/2015.
//
//

#import "Utils.h"
@implementation Utils
@end

static NSMutableDictionary *Memoables;

@implementation NSObject (Utils)

+ (void)load {
    Memoables = [NSMutableDictionary new];
}

#pragma mark - Memoable

+ (id)memoable {
    id memo = Memoables[[self memoKey]];
    return memo ? memo : (Memoables[[self memoKey]] = [NSMutableDictionary new]);
}

+ (NSString *)memoKey {
    return @"NSObject";
}

+ (instancetype)memo:(NSString *)name {
    return [self memoable][name];
}

- (void)memo:(NSString *)name {
    [[self class] memoable][name] = self;
}

#pragma mark - Setupable

+ (instancetype)setup:(void (^)(id))setup {
    return [[self new] setup:setup];
}

- (instancetype)setup:(void (^)(id))setup {
    setup(self);
    return self;
}

@end

