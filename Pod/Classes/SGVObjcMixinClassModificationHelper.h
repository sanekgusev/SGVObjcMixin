//
//  SGVClassModificationHelper.h
//  SGVObjcMixin
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGVObjcMixinClassModificationHelper : NSObject

+ (NSString *)modifiedClassNameForClass:(Class __unsafe_unretained)class
        withMixinClass:(Class __unsafe_unretained)mixinClass;

+ (BOOL)isClass:(Class __unsafe_unretained)class
modifiedWithMixinClass:(Class __unsafe_unretained)mixinClass
originalClass:(Class __unsafe_unretained *)originalClass;

+ (Class)createdOrExistingModifiedClassForClass:(Class __unsafe_unretained)class
    mixinClass:(Class __unsafe_unretained)mixinClass
error:(NSError * __autoreleasing *)error;

@end
