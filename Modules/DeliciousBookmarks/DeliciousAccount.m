//
//  DeliciousAccount.m
//
//  Copyright (c) 2009 Nathan Parry. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are
//  met:
//
//    * Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//    * Redistributions in binary form must reproduce the above
//  copyright notice, this list of conditions and the following disclaimer
//  in the documentation and/or other materials provided with the
//  distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "DeliciousAccount.h"
#import "HGSAccountsExtensionPoint.h"
#import "HGSBundle.h"
#import "HGSLog.h"
#import "KeychainItem.h"

static NSString *const kSetUpDeliciousAccountViewNibName
  = @"SetUpDeliciousAccountView";
static NSString *const kDeliciousAccountTypeName = @"Delicious";;

// A class which manages a Delicious account.
@interface DeliciousAccount : HGSSimpleAccount

@end

@implementation DeliciousAccount

+ (NSString *)accountType {
  return kDeliciousAccountTypeName;
}

+ (NSView *)accountSetupViewToInstallWithParentWindow:(NSWindow *)parentWindow {
  static HGSSetUpSimpleAccountViewController *sSetUpDeliciousAccountViewController = nil;
  if (!sSetUpDeliciousAccountViewController) {
    NSBundle *ourBundle = HGSGetPluginBundle();
    HGSSetUpSimpleAccountViewController *loadedViewController
      = [[[SetUpDeliciousAccountViewController alloc]
          initWithNibName:kSetUpDeliciousAccountViewNibName bundle:ourBundle]
         autorelease];
    if (loadedViewController) {
      [loadedViewController loadView];
      sSetUpDeliciousAccountViewController = [loadedViewController retain];
    } else {
      HGSLog(@"Failed to load nib '%@'.", kSetUpDeliciousAccountViewNibName);
    }
  }
  [sSetUpDeliciousAccountViewController setParentWindow:parentWindow];
  return [sSetUpDeliciousAccountViewController view];
}

- (NSString *)editNibName {
  return @"EditDeliciousAccount";
}

- (BOOL)authenticateWithPassword:(NSString *)password {
  // TODO
  [self setIsAuthenticated:YES];
  return YES;  // Return as convenience.
}

@end

@implementation DeliciousAccountEditController

@end

@implementation SetUpDeliciousAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil
                         bundle:nibBundleOrNil
               accountTypeClass:[DeliciousAccount class]];
  return self;
}

@end