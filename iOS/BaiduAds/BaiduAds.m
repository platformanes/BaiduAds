/*
 
 Copyright (c) 2012, DIVIJ KUMAR
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met: 
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer. 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution. 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies, 
 either expressed or implied, of the FreeBSD Project.
 
 
 */

/*
 * BaiduAds.m
 * BaiduAds
 *
 * Created by rect on 14-1-8.
 * Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
 */

#import "BaiduAds.h"

/* BaiduAdsExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void BaiduAdsExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering BaiduAdsExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;

    NSLog(@"Exiting BaiduAdsExtInitializer()");
}

/* BaiduAdsExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void BaiduAdsExtFinalizer(void* extData) 
{
    NSLog(@"Entering BaiduAdsExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting BaiduAdsExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(isSupported, NULL),
        
        MAP_FUNCTION(baiduads_function_splash, NULL),
        MAP_FUNCTION(baiduads_function_simple_dec, NULL),
        MAP_FUNCTION(baiduads_function_simple_code, NULL),
        MAP_FUNCTION(baiduads_function_video, NULL),
        MAP_FUNCTION(baiduads_function_interad, NULL),
        MAP_FUNCTION(baiduads_function_iconsad, NULL),
        MAP_FUNCTION(baiduads_function_exit, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    P_handler = [[BaiduModHandle alloc] initWithContext:ctx];
    
    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ContextFinalizer(FREContext ctx) 
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


/* This is a TEST function that is being included as part of this template. 
 *
 * Users of this template are expected to change this and add similar functions 
 * to be able to call the native functions in the ANE from their ActionScript code
 */
ANE_FUNCTION(isSupported)
{
    NSLog(@"Entering IsSupported()");
    
    FREObject fo;
    
    FREResult aResult = FRENewObjectFromBool(YES, &fo);
    if (aResult == FRE_OK)
    {
        NSLog(@"Result = %d", aResult);
    }
    else
    {
        NSLog(@"Result = %d", aResult);
    }
    
	NSLog(@"Exiting IsSupported()");    
	return fo;
}

ANE_FUNCTION(baiduads_function_splash)
{
    FREObject fo;
    FRENewObjectFromBool(YES, &fo);
    
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_SPLASH level:@"this func just in android"];
    return fo;
}


ANE_FUNCTION(baiduads_function_simple_dec)
{
    FREObject fo;
    FRENewObjectFromBool(YES, &fo);
    NSLog(@"entering baiduads_function_simple_dec");
    if (P_handler != NULL) {
        NSLog(@"entering p is not null");
    }
    else
        NSLog(@"entering p is null");
    [P_handler sendMsgToAs:@"tttt" level:@"this func just in android"];
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_DES level:@"this func just in android"];
    NSLog(@"exiting baiduads_function_simple_dec");
    return fo;
}


ANE_FUNCTION(baiduads_function_simple_code)
{
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_CODE level:@"this func just in android"];
    return NULL;
}


ANE_FUNCTION(baiduads_function_video)
{
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_VIDEO level:@"this func just in android"];
    return NULL;
}


ANE_FUNCTION(baiduads_function_interad)
{
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_INTER level:@"this func just in android"];
    return NULL;
}


ANE_FUNCTION(baiduads_function_iconsad)
{
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_ICON level:@"this func just in android"];
    return NULL;
}


ANE_FUNCTION(baiduads_function_exit)
{
    [P_handler sendMsgToAs:(NSString *)BAIDUADS_EXIT level:@"this func just in android"];
    return NULL;
}



// FREObject to int
int getIntFromFreObject(FREObject freObject)
{
    int32_t value;
    FREGetObjectAsInt32(freObject, &value);
    return value;
    
}

/*
 *将FREObject转成NSString
 */
NSString * getStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}

BOOL getBoolFormFreObject(FREObject freObject)
{
    uint32_t value;
    FREGetObjectAsBool(freObject,&value);
    return (BOOL)value;
}


















