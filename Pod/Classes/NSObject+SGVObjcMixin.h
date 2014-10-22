//
//  NSObject+SGVObjcMixin.h
//  Pods
//
//  Created by Aleksandr Gusev on 21/10/14.
//
//

#import <Foundation/Foundation.h>
#import "SGVObjcMixinErrors.h"

@interface NSObject (SGVObjcMixin)

- (BOOL)sgv_mixinClass:(Class __unsafe_unretained)mixinClass
                 error:(NSError * __autoreleasing *)error;

- (BOOL)sgv_unmixinClass:(Class __unsafe_unretained)mixinClass
                   error:(NSError * __autoreleasing *)error;

@end
