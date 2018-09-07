//
//  NSMutableArray+Filtering.h
//  InPlaceFilteringArray
//
//  Created by Andrei Ermoshin on 07/09/2018.
//  Copyright © 2018 Andrei Ermoshin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Filtering)

- (void)filterArrayPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;

@end
