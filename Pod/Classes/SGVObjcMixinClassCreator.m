//
//  SGVMixinHelper.m
//  SGVObjcMixin
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import "SGVObjcMixinClassCreator.h"
#import <objc/runtime.h>
#import "SGVObjcMixinErrors.h"

@implementation SGVObjcMixinClassCreator

#pragma mark - Public

+ (Class)classWithName:(NSString *)className
createdByInheritingFromClass:(Class __unsafe_unretained)parentClass
andMixingInMethodsFromClass:(Class __unsafe_unretained)mixinClass
                 error:(NSError * __autoreleasing *)error {
    NSCParameterAssert(className);
    NSCParameterAssert(parentClass);
    NSCParameterAssert(mixinClass);
    if (!className || !parentClass || !mixinClass) {
        return nil;
    }
    
    void (^setErrorBlock)(NSInteger, NSString *) = ^(NSInteger code, NSString *description) {
        if (error) {
            *error = [self errorWithCode:code description:description];
        }
    };
    
    Class __unsafe_unretained mixinClassSuperclass = class_getSuperclass(mixinClass);
    if (![parentClass isSubclassOfClass:mixinClassSuperclass]) {
        setErrorBlock(kSGVObjcMixinClassCreatorUnsupportedMixinSuperclass,
                      @"The immediate superclass of mixinClass should be in inheritance hierarchy of parentClass.");
        return nil;
    }
    Class __unsafe_unretained newClass = objc_allocateClassPair(parentClass,
                                                                [className UTF8String],
                                                                0);
    if (!newClass) {
        setErrorBlock(kSGVObjcMixinClassCreatorClassAllocationError,
                      @"objc_allocateClassPair() failed, class with specified name already exists?");
        return nil;
    }
    
    unsigned int ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(mixinClass, &ivarsCount);
    free(ivars);
    if (ivarsCount > 0) {
        setErrorBlock(kSGVObjcMixinClassCreatorUnsupprtedMixinWithIvars,
                      @"mixing in classes with ivars is not supported.");
        return nil;
    }
    
    unsigned int methodsCount = 0;
    Method *methods = class_copyMethodList(mixinClass,
                                           &methodsCount);
    for (unsigned int i = 0; i < methodsCount; i++) {
        Method method = methods[i];
        BOOL __unused added = class_addMethod(newClass,
                                              method_getName(method),
                                              method_getImplementation(method),
                                              method_getTypeEncoding(method));
        NSCAssert(added, @"Method should be added successfully");
    }
    free(methods);
    
    objc_registerClassPair(newClass);
    
    return newClass;
}

#pragma mark - Private

+ (NSError *)errorWithCode:(NSInteger)code
               description:(NSString *)description {
    NSCParameterAssert(description);
    if (!description) {
        return nil;
    }
    return [NSError errorWithDomain:kSGVObjcMixinClassCreatorErrorDomain
                               code:code
                           userInfo:@{NSLocalizedDescriptionKey: description}];
}

@end
