//
// Created by Marcelo Schroeder on 4/06/2014.
// Copyright (c) 2014 InfoAccent Pty Ltd. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <Foundation/Foundation.h>


@interface IFACrashlyticsSupportManager : NSObject

/**
* Configure crash reporting using the Crashlytics framework.
* Crashlytics API key must be set in the app's main PList using the 'IFACrashlyticsApiKey' key.
*
* @param a_userInfo User info dictionary containing key/value pairs that are displayed in the 'Keys' section of a crash report on www.crashlytics.com. This method will do its best to format the non string values provided appropriately.
*/
-(void)configureCrashReportingWithUserInfo:(NSDictionary*)a_userInfo;

+ (instancetype)sharedInstance;

@end