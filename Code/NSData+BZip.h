//
//  NSData+BZip.h
//  OpenerCore
//
//  Created by Tim Johnsen on 3/29/20.
//  Copyright © 2020 tijo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (BZip)

- (nullable instancetype)tj_bzipDecompressedData;

@end

NS_ASSUME_NONNULL_END
