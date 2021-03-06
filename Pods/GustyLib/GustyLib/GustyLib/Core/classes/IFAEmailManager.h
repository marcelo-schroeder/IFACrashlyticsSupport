//
//  IFAEmailManager.h
//  Gusty
//
//  Created by Marcelo Schroeder on 16/02/12.
//  Copyright (c) 2012 InfoAccent Pty Limited. All rights reserved.
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

@interface IFAEmailManager : NSObject <MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, strong) void (^completionBlock)(void);

-(id)initWithParentViewController:(UIViewController*)a_parentViewController;
-(id)initWithParentViewController:(UIViewController*)a_parentViewController completionBlock:(void (^)(void))a_completionBlock;
-(void)composeEmailWithSubject:(NSString *)a_subject recipient:(NSString *)a_recipient body:(NSString*)a_body;
-(void)composeEmailWithSubject:(NSString *)a_subject recipient:(NSString *)a_recipient body:(NSString *)a_body
                 attachmentUrl:(NSURL *)a_attachmentUrl attachmentMimeType:(NSString*)a_attachmentMimeType;

@end
