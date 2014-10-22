//
//  SGVMixinHelper.h
//  SGVObjcMixin
//
//  Created by Aleksandr Gusev on 9/4/14.
//  Copyright (c) 2014 sanekgusev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGVObjcMixinClassCreator : NSObject

+ (Class)classWithName:(NSString *)className
 createdByInheritingFromClass:(Class __unsafe_unretained)parentClass
andMixingInMethodsFromClass:(Class __unsafe_unretained)mixinClass
                 error:(NSError * __autoreleasing *)error;

@end
