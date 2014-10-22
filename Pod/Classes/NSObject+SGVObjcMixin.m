//
//  NSObject+SGVObjcMixin.m
//  Pods
//
//  Created by Aleksandr Gusev on 21/10/14.
//
//

#import "NSObject+SGVObjcMixin.h"
#import "SGVObjcMixinClassModificationHelper.h"
#import <objc/runtime.h>

@implementation NSObject (SGVObjcMixin)

- (BOOL)sgv_mixinClass:(Class __unsafe_unretained)mixinClass
                 error:(NSError * __autoreleasing *)error {
    NSCParameterAssert(mixinClass);
    if (!mixinClass) {
        return NO;
    }
    Class modifiedClass = [SGVObjcMixinClassModificationHelper createdOrExistingModifiedClassForClass:object_getClass(self)
                                                                                           mixinClass:mixinClass
                                                                                                error:error];
    if (!modifiedClass) {
        return NO;
    }
    object_setClass(self, modifiedClass);
    return YES;
}

- (BOOL)sgv_unmixinClass:(Class __unsafe_unretained)mixinClass
                   error:(NSError * __autoreleasing *)error {
    NSCParameterAssert(mixinClass);
    if (!mixinClass) {
        return NO;
    }
    Class __unsafe_unretained originalClass;
    BOOL isModified = [SGVObjcMixinClassModificationHelper isClass:object_getClass(self)
                                            modifiedWithMixinClass:mixinClass
                                                     originalClass:&originalClass];
    if (!isModified) {
        if (error) {
            *error = [NSError errorWithDomain:kSGVObjcMixinErrorDomain
                                         code:kSGVObjcMixinClassNotModified
                                     userInfo:@{NSLocalizedDescriptionKey: @"Object's class has not been modified with specified mixin class."}];
        }
        return NO;
    }
    object_setClass(self, originalClass);
    return YES;
}

@end
