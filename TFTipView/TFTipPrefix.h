//
//  TFTipPrefix.h
//  bosfera
//
//  Created by Dima Avvakumov on 25.04.13.
//  Copyright (c) 2013 East Media LTD. All rights reserved.
//

#ifndef bosfera_TFTipPrefix_h
#define bosfera_TFTipPrefix_h

#ifndef TFTIP_STRONG
#if __has_feature(objc_arc)
#define TFTIP_STRONG strong
#else
#define TFTIP_STRONG retain
#endif
#endif

#ifndef TFTIP_WEAK
#if __has_feature(objc_arc_weak)
#define TFTIP_WEAK weak
#elif __has_feature(objc_arc)
#define TFTIP_WEAK unsafe_unretained
#else
#define TFTIP_WEAK assign
#endif
#endif

#if __has_feature(objc_arc)
#define TFTIP_AUTORELEASE(exp) exp
#define TFTIP_RELEASE(exp) exp
#define TFTIP_RETAIN(exp) exp
#else
#define TFTIP_AUTORELEASE(exp) [exp autorelease]
#define TFTIP_RELEASE(exp) [exp release]
#define TFTIP_RETAIN(exp) [exp retain]
#endif


#endif
