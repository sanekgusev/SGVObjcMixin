//
//  SGVClassModificationHelper.m
//  SGVObjcMixin
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVObjcMixinClassModificationHelper.h"
#import <objc/runtime.h>
#import "SGVObjcMixinClassCreator.h"

static NSString * const kMixinClassPrefix = @"_sgv_";

@implementation SGVObjcMixinClassModificationHelper

+ (NSString *)modifiedClassNameForClass:(Class __unsafe_unretained)class
                         withMixinClass:(Class __unsafe_unretained)mixinClass {
    NSCParameterAssert(class);
    NSCParameterAssert(mixinClass);
    if (!class || !mixinClass) {
        return nil;
    }
    NSString *className = @(class_getName(class));
    NSString *mixinClassName = @(class_getName(mixinClass));
    return [NSString stringWithFormat:@"%@%@%@",
            className,
            kMixinClassPrefix,
            mixinClassName];
}

+ (BOOL)isClass:(Class __unsafe_unretained)class
modifiedWithMixinClass:(Class __unsafe_unretained)mixinClass
  originalClass:(Class __unsafe_unretained *)originalClass {
    NSCParameterAssert(class);
    NSCParameterAssert(mixinClass);
    if (!class || !mixinClass) {
        return NO;
    }
    NSString *className = @(class_getName(class));
    NSString *mixinClassNameWithPrefix = [NSString stringWithFormat:@"%@%@",
                                          kMixinClassPrefix,
                                          @(class_getName(mixinClass))];
    NSUInteger mixinPosition = [className rangeOfString:mixinClassNameWithPrefix].location;
    BOOL classIsMofified = mixinPosition == [className length] - [mixinClassNameWithPrefix length];
    if (classIsMofified && originalClass) {
        NSString *originalClassName = [className substringToIndex:mixinPosition];
        *originalClass = objc_lookUpClass([originalClassName UTF8String]);
    }
    return classIsMofified;
}

+ (Class)createdOrExistingModifiedClassForClass:(Class __unsafe_unretained)class
                                     mixinClass:(Class __unsafe_unretained)mixinClass
                                          error:(NSError * __autoreleasing *)error {
    NSCParameterAssert(class);
    NSCParameterAssert(mixinClass);
    if (!class || !mixinClass) {
        return nil;
    }
    NSString *modifiedClassName = [self modifiedClassNameForClass:class
                                                   withMixinClass:mixinClass];
    Class __unsafe_unretained modifiedClass = objc_lookUpClass([modifiedClassName UTF8String]);
    if (modifiedClass) {
        return modifiedClass;
    }
    return [SGVObjcMixinClassCreator classWithName:modifiedClassName
                      createdByInheritingFromClass:class
                       andMixingInMethodsFromClass:mixinClass
                                             error:error];
}

@end
