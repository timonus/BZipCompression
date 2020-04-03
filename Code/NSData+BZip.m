//
//  NSData+BZip.m
//  OpenerCore
//
//  Created by Tim Johnsen on 3/29/20.
//  Copyright © 2020 tijo. All rights reserved.
//

#import "NSData+BZip.h"
#import <bzlib.h>

static const NSUInteger BZipCompressionBufferSize = 1024;

@implementation NSData (BZip)

// Inspired by https://github.com/blakewatters/BZipCompression
- (instancetype)tj_bzipDecompressedData
{
    bz_stream stream;
    bzero(&stream, sizeof(stream));
    stream.next_in = (char *)self.bytes;
    stream.avail_in = (unsigned int)self.length;

    char buffer[BZipCompressionBufferSize];
    stream.next_out = buffer;
    stream.avail_out = BZipCompressionBufferSize;

    int bzret;
    bzret = BZ2_bzDecompressInit(&stream, 0, NO);
    if (bzret != BZ_OK) {
        NSLog(@"BZ2_bzDecompressInit failed!");
        return nil;
    }

    NSMutableData *decompressedData = [NSMutableData data];
    do {
        bzret = BZ2_bzDecompress(&stream);
        if (bzret < BZ_OK) {
            NSLog(@"BZ2_bzDecompress failed!");
            return nil;
        }

        [decompressedData appendBytes:buffer length:(BZipCompressionBufferSize - stream.avail_out)];
        stream.next_out = buffer;
        stream.avail_out = BZipCompressionBufferSize;
    } while (bzret != BZ_STREAM_END);

    BZ2_bzDecompressEnd(&stream);
    
    return decompressedData;
}

@end
