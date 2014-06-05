//
//  IFAUIUtils.m
//  Gusty
//
//  Created by Marcelo Schroeder on 17/06/10.
//  Copyright 2010 InfoAccent Pty Limited. All rights reserved.
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

#import "IFACommon.h"

static UIImage *c_menuBarButtonItemImage = nil;

@implementation IFAUIUtils

#pragma mark - Private

+(IFA_MBProgressHUD *)hudWithText:(NSString*)a_text animation:(MBProgressHUDAnimation)a_animationType inView:(UIView*)a_view{
    IFA_MBProgressHUD *l_hud = [[IFA_MBProgressHUD alloc] initWithView:a_view];
    l_hud.customView = nil;
    l_hud.mode = MBProgressHUDModeCustomView;
    l_hud.opacity = 0.6;
    l_hud.userInteractionEnabled = NO;
    l_hud.removeFromSuperViewOnHide = YES;
    l_hud.animationType = a_animationType;
    l_hud.labelText = a_text;
    return l_hud;
}

+(IFA_MBProgressHUD *)showHudWithText:(NSString*)a_text animation:(MBProgressHUDAnimation)a_animationType inView:(UIView*)a_view animate:(BOOL)a_animated{
    UIView *l_view = a_view;
    if (!l_view) {
        l_view = [IFAUIUtils nonModalHudContainerView];
    }
    IFA_MBProgressHUD *l_hud = [self hudWithText:a_text animation:a_animationType inView:l_view];
    [l_view addSubview:l_hud];
    [l_hud show:a_animated];
    return l_hud;
}

+(void)IFA_traverseHierarchyForView:(UIView *)a_view withBlock:(void (^) (UIView *))a_block level:(NSUInteger)a_level{

//    NSMutableString *l_indentation = [NSMutableString string];
//    for (int i=0; i<a_level; i++) {
//        [l_indentation appendString:@" "];
//    }
//    NSLog(@"%@ %u a_superview: %@", l_indentation, a_level, [a_view description]);
    
    a_block(a_view);

    NSUInteger l_subviewLevel = a_level + 1;

    if ([a_view isKindOfClass:[UITableView class]]) {

        UITableView *l_tableView = (UITableView*)a_view;
        NSMutableSet *l_fullyVisibleIndexPaths = [NSMutableSet new];
        for (UITableViewCell *l_tableViewCell in l_tableView.visibleCells) {
            NSIndexPath *l_indexPath = [l_tableView indexPathForCell:l_tableViewCell];
//            if ([l_tableView m_isCellFullyVisibleForRowAtIndexPath:l_indexPath]) {
            [self IFA_traverseHierarchyForView:l_tableViewCell withBlock:a_block level:l_subviewLevel];
                [l_fullyVisibleIndexPaths addObject:l_indexPath];
//            }
        }
        NSMutableSet *l_visibleSections = [NSMutableSet new];
        for (NSIndexPath *l_indexPath in l_fullyVisibleIndexPaths) {
            @autoreleasepool {
                NSNumber *l_section = [NSNumber numberWithUnsignedInteger:l_indexPath.section];
                [l_visibleSections addObject:l_section];
            }
        }
        for (NSNumber *l_section in l_visibleSections) {
            @autoreleasepool {
                if ([l_tableView.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
                    UIView *l_sectionHeaderView = [l_tableView.delegate tableView:l_tableView
                                                           viewForHeaderInSection:[l_section unsignedIntegerValue]];
                    [self IFA_traverseHierarchyForView:l_sectionHeaderView withBlock:a_block level:l_subviewLevel];
                }
                if ([l_tableView.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
                    UIView *l_sectionFooterView = [l_tableView.delegate tableView:l_tableView
                                                           viewForFooterInSection:[l_section unsignedIntegerValue]];
                    [self IFA_traverseHierarchyForView:l_sectionFooterView withBlock:a_block level:l_subviewLevel];
                }
            }
        }
        [self IFA_traverseHierarchyForView:l_tableView.tableHeaderView withBlock:a_block level:l_subviewLevel];
        [self IFA_traverseHierarchyForView:l_tableView.tableFooterView withBlock:a_block level:l_subviewLevel];

    }else {
        
        // The check below is to avoid going deeper into Apple's private implementations and other class kinds that could cause issues
        if ([a_view isKindOfClass:[UIDatePicker class]] || [a_view isKindOfClass:[UIPickerView class]] || [a_view isKindOfClass:[IFA_MBProgressHUD class]]) {
            return;
        }
        
        // Go deeper...
        for (UIView *l_subview in a_view.subviews) {
            [self IFA_traverseHierarchyForView:l_subview withBlock:a_block level:l_subviewLevel];
        }

    }

}

#pragma mark - Public

+ (void) showAlertWithMessage:(NSString*)aMessage title:(NSString*)aTitle{
	[self showAlertWithMessage:aMessage 
						 title:aTitle 
					  delegate:nil
				   buttonLabel:nil];
}

+ (void) showAlertWithMessage:(NSString*)aMessage title:(NSString*)aTitle buttonLabel:(NSString*)aButtonLabel{
	[self showAlertWithMessage:aMessage 
						 title:aTitle 
					  delegate:nil
				   buttonLabel:aButtonLabel];
}

+ (void) showAlertWithMessage:(NSString*)aMessage title:(NSString*)aTitle delegate:(id)aDelegate{
	[self showAlertWithMessage:aMessage 
						 title:aTitle 
					  delegate:aDelegate
				   buttonLabel:nil];
}

+ (void) showAlertWithMessage:(NSString*)aMessage 
						title:(NSString*)aTitle 
					 delegate:(id)aDelegate 
				  buttonLabel:(NSString*)aButtonLabel{
    [self showAlertWithMessage:aMessage title:aTitle delegate:aDelegate buttonLabel:aButtonLabel tag:NSNotFound];
}

+ (void) showAlertWithMessage:(NSString*)aMessage title:(NSString*)aTitle delegate:(id)aDelegate buttonLabel:(NSString*)aButtonLabel tag:(NSInteger)aTag{
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage
												   delegate:aDelegate
										  cancelButtonTitle:(aButtonLabel==nil?@"Continue":aButtonLabel)
										  otherButtonTitles:nil];
//	alert.accessibilityLabel = aTitle;
    if (aTag!=NSNotFound) {
        alert.tag = aTag;
    }
	[alert show];
}

+(UIView*)actionSheetShowInViewForViewController:(UIViewController*)a_viewController{
    UIView *l_view = nil;
    if (!(l_view = a_viewController.tabBarController.view)) {
        if (!(l_view = a_viewController.splitViewController.view)) {
            l_view = a_viewController.navigationController.toolbar;
            if (!l_view) {
                l_view = a_viewController.view;
            }
        }
    }
    return l_view;
}

+ (void) showActionSheetWithMessage:(NSString*)aMessage
	   destructiveButtonLabelSuffix:(NSString*)aDestructiveButtonLabelSuffix
                     viewController:(UIViewController*)aViewController
                      barButtonItem:(UIBarButtonItem*)aBarButtonItem
						   delegate:(id<UIActionSheetDelegate>)aDelegate{
	[self showActionSheetWithMessage:aMessage 
		destructiveButtonLabelSuffix:aDestructiveButtonLabelSuffix 
                      viewController:aViewController
                       barButtonItem:aBarButtonItem
							delegate:aDelegate
								 tag:0];
}

+ (void) showActionSheetWithMessage:(NSString*)aMessage 
	   destructiveButtonLabelSuffix:(NSString*)aDestructiveButtonLabelSuffix
                     viewController:(UIViewController*)aViewController
                      barButtonItem:(UIBarButtonItem*)aBarButtonItem
						   delegate:(id<UIActionSheetDelegate>)aDelegate
								tag:(NSInteger)aTag{
	[self showActionSheetWithMessage:aMessage 
			 cancelButtonLabelSuffix:nil 
		destructiveButtonLabelSuffix:aDestructiveButtonLabelSuffix 
								view:[self actionSheetShowInViewForViewController:aViewController]
                       barButtonItem:aBarButtonItem
							delegate:aDelegate
								 tag:aTag];
}

+ (void) showActionSheetWithMessage:(NSString*)aMessage 
			cancelButtonLabelSuffix:(NSString*)aCancelButtonLabelSuffix 
	   destructiveButtonLabelSuffix:(NSString*)aDestructiveButtonLabelSuffix
							   view:(UIView*)aView
                      barButtonItem:(UIBarButtonItem*)aBarButtonItem
						   delegate:(id<UIActionSheetDelegate>)aDelegate
								tag:(NSInteger)aTag{
	UIActionSheet *actionSheet = 
		[[UIActionSheet alloc] initWithTitle:aMessage
									delegate:aDelegate 
						   cancelButtonTitle:[@"No" stringByAppendingString:(aCancelButtonLabelSuffix?[NSString stringWithFormat:@", %@", aCancelButtonLabelSuffix]:@"")]
					  destructiveButtonTitle:[@"Yes, " stringByAppendingString:aDestructiveButtonLabelSuffix]
						   otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
//    NSLog(@"aView: %@", [aView description]);
    if ([IFAUIUtils isIPad] && aBarButtonItem) {
        [actionSheet showFromBarButtonItem:aBarButtonItem animated:YES];
    }else {
        [actionSheet showInView:aView];
    }
	if(aTag!=0){
		actionSheet.tag = aTag;
	}
}

+(NSString*)helpTargetIdForName:(NSString*)a_name{
    return [NSString stringWithFormat:@"controllers.common.%@", a_name];
}

+ (UIBarButtonItem*) barButtonItemForType:(NSUInteger)aType target:(id)aTarget action:(SEL)anAction{
	UIBarButtonItem *barButtonItem;
	switch (aType) {
		case IFABarButtonItemCancel:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"cancelButton"];
//			barButtonItem.accessibilityLabel = @"Cancel Button";
			break;
		case IFABarButtonItemDone:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"doneButton"];
            [[[IFAAppearanceThemeManager sharedInstance] activeAppearanceTheme] setAppearanceForBarButtonItem:barButtonItem
                                                                                              viewController:nil
                                                                                                   important:YES ];
//			barButtonItem.accessibilityLabel = @"Done Button";
			break;
		case IFABarButtonItemDelete:
			barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"310-RemoveButton.png"] style:UIBarButtonItemStylePlain target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"deleteButton"];
//			barButtonItem.accessibilityLabel = @"Delete Button";
			break;
		case IFABarButtonItemFlexibleSpace:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:aTarget action:anAction];
			break;
		case IFABarButtonItemFixedSpace:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:aTarget action:anAction];
			barButtonItem.width = 5;
			break;
		case IFABarButtonItemAdd:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:aTarget action:anAction];
            barButtonItem.tag = 10000;
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"addButton"];
//			barButtonItem.accessibilityLabel = @"Add Button";
			break;
		case IFABarButtonItemSelectNone:
		{
			NSString *l_title = [IFAUtils infoPList][@"IFASelectNoneButtonLabel"];
            if (!l_title) {
                l_title = @"Select None";
            }
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:l_title style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"selectNoneButton"];
//			barButtonItem.accessibilityLabel = @"Select None Button";
			break;
		}
		case IFABarButtonItemSelectAll:
		{
			NSString *l_title = @"Select All";
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:l_title style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"selectAllButton"];
//			barButtonItem.accessibilityLabel = @"Select All Button";
			break;
		}
		case IFABarButtonItemPreviousPage:
			barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"191-ArrowHead-left"] style:UIBarButtonItemStylePlain target:aTarget action:anAction];
//			barButtonItem.accessibilityLabel = @"Previous Page Button";
			break;
		case IFABarButtonItemNextPage:
			barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"191-ArrowHead-right"] style:UIBarButtonItemStylePlain target:aTarget action:anAction];
//			barButtonItem.accessibilityLabel = @"Next Page Button";
			break;
		case IFABarButtonItemSelectNow:
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Now" style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"nowButton"];
//			barButtonItem.accessibilityLabel = @"Now Button";
			break;
		case IFABarButtonItemSelectToday:
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"todaySelectionButton"];
//			barButtonItem.accessibilityLabel = @"Today Button";
			break;
		case IFABarButtonItemAction:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:aTarget action:anAction];
//			barButtonItem.accessibilityLabel = @"Action Button";
			break;
		case IFABarButtonItemRefresh:
			barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:aTarget action:anAction];
//			barButtonItem.accessibilityLabel = @"Refresh Button";
			break;
		case IFABarButtonItemDismiss:
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"dismissButton"];
//			barButtonItem.accessibilityLabel = @"Dismiss Button";
			break;
		case IFABarButtonItemBack:
			barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:aTarget action:anAction];
            barButtonItem.helpTargetId = [self helpTargetIdForName:@"backButton"];
//			barButtonItem.accessibilityLabel = @"Back Button";
			break;
		default:
			NSAssert(NO, @"Unexpected button item code: %u", aType);
			break;
	}
	return barButtonItem;
}

+ (CGPoint)appFrameOrigin{
	return [self appFrame].origin;
}

+ (CGSize)appFrameSize{
	return [self appFrame].size;
}

+ (CGRect)appFrame{
	return [[UIScreen mainScreen] applicationFrame];
}

+ (CGRect)convertToCurrentOrientationForFrame:(CGRect)a_frame{
    return [self isDeviceInLandscapeOrientation] ? CGRectMake(a_frame.origin.y, a_frame.origin.x, a_frame.size.height, a_frame.size.width) : a_frame;
}

+ (CGPoint)screenBoundsOrigin{
	return [self screenBounds].origin;
}

+ (CGSize)screenBoundsSize{
	return [self screenBounds].size;
}

+ (CGSize)screenBoundsSizeForCurrentOrientation{
    CGSize l_screenBoundsSize = [self screenBoundsSize];
    return [self isDeviceInLandscapeOrientation] ? CGSizeMake(l_screenBoundsSize.height, l_screenBoundsSize.width) : l_screenBoundsSize;
}

+ (CGRect)screenBounds{
	return [UIScreen mainScreen].bounds;
}

+ (CGSize)statusBarSize{
	return [self statusBarFrame].size;
}

+ (CGSize)statusBarSizeForCurrentOrientation{
    CGSize l_statusBarSize = [self statusBarSize];
    return [self isDeviceInLandscapeOrientation] ? CGSizeMake(l_statusBarSize.height, l_statusBarSize.width) : l_statusBarSize;
}

+ (CGRect)statusBarFrame{
    return [[UIApplication sharedApplication] statusBarFrame];
}

+(BOOL)isDeviceInLandscapeOrientation{
//    NSLog(@"[UIApplication sharedApplication].statusBarOrientation: %u", [UIApplication sharedApplication].statusBarOrientation);
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}

+ (NSString*)stringValueForObject:(id)anObject{
//    NSLog(@"stringValueForObject: %@", [anObject description]);
	if (anObject==nil) {
		return anObject;
	}else if ([anObject isKindOfClass:[NSString class]]) {
		return anObject;
	}else if ([anObject isKindOfClass:[NSDate class]]) {
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
		return [dateFormatter stringFromDate:anObject];
	}else if ([anObject isKindOfClass:[NSManagedObject class]]) {
		return [anObject ifa_longDisplayValue];
	}else if ([anObject isKindOfClass:[NSSet class]]) {
		if ([anObject count]==0) {
			return @"";
		}else {
			NSString *l_entityName = [((NSManagedObject *) [anObject anyObject]) ifa_entityName];
			NSArray *sortDescriptors = [[IFAPersistenceManager sharedInstance] listSortDescriptorsForEntity:l_entityName];
			NSArray *sortedArray = [[anObject allObjects] sortedArrayUsingDescriptors:sortDescriptors];
			NSMutableString *l_string = [NSMutableString string];
			BOOL l_firstTime = YES;
			for (NSManagedObject *l_managedObject in sortedArray) {
				if (l_firstTime) {
					l_firstTime = NO;
				}else {
					[l_string appendString:@", "];
				}
				[l_string appendString:[l_managedObject ifa_displayValue]];
			}
			return l_string;
		}
	}else {
		NSAssert(NO, @"Unexpected class: %@", [[anObject class] description]);
		return @"***UNKNOWN***";
	}
}

+ (NSString*)stringValueForBoolean:(BOOL)aBoolean{
    return aBoolean ? @"yes" : @"no";
}

+ (NSString*)onOffStringValueForBoolean:(BOOL)aBoolean{
    return aBoolean ? @"on" : @"off";
}

+(IFA_MBProgressHUD *)showHudWithText:(NSString*)a_text{
    return [self showHudWithText:a_text inView:nil animated:YES];
}

+(IFA_MBProgressHUD *)showHudWithText:(NSString*)a_text inView:(UIView*)a_view animated:(BOOL)a_animated{
    return [self showHudWithText:a_text animation:MBProgressHUDAnimationZoom inView:a_view animate:a_animated];
}

+(void)hideHud:(IFA_MBProgressHUD *)a_hud animated:(BOOL)a_animated{
    [a_hud hide:a_animated];
}

+(void)hideHud:(IFA_MBProgressHUD *)a_hud{
    [self hideHud:a_hud animated:YES];
}

+ (void)showAndHideUserActionConfirmationHudWithText:(NSString*)a_text{
    IFA_MBProgressHUD *l_hud = [self showHudWithText:a_text animation:MBProgressHUDAnimationFade inView:nil animate:YES];
    l_hud.minShowTime = 1;
    [self hideHud:l_hud];
}

+ (void)showAndHideModeToggleConfirmationHudWithText:(NSString*)a_text on:(BOOL)a_on{
    NSString *l_text = [NSString stringWithFormat: @"%@ %@", a_text, [IFAUIUtils onOffStringValueForBoolean:a_on]];
    [self showAndHideUserActionConfirmationHudWithText:l_text];
}

+(UIView*)nonModalHudContainerView{
    UIView *l_view = nil;
    UIWindow *l_window = [UIApplication sharedApplication].delegate.window;
    if ([l_window.rootViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *l_splitViewController = (UISplitViewController*) l_window.rootViewController;
        UIViewController *l_detailViewController = [l_splitViewController.viewControllers objectAtIndex:1];
        l_view = l_detailViewController.view;
    }else{
        l_view = l_window;
    };
    return l_view;
}

+(void)postNavigationEventNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:IFANotificationNavigationEvent object:nil];
//    NSLog(@"IFANotificationNavigationEvent sent");
}

+(void)traverseHierarchyForView:(UIView *)a_view withBlock:(void (^) (UIView*))a_block{
    [self IFA_traverseHierarchyForView:a_view withBlock:a_block level:0];
}

+(CGFloat)widthForPortraitNumerator:(float)a_portraitNumerator
                portraitDenominator:(float)a_portraitDenominator
                 landscapeNumerator:(float)a_landscapeNumerator
               landscapeDenominator:(float)a_landscapeDenominator
{
    float l_numerator = [IFAUIUtils isDeviceInLandscapeOrientation] ? a_landscapeNumerator : a_portraitNumerator;
    float l_denominator = [IFAUIUtils isDeviceInLandscapeOrientation] ? a_landscapeDenominator : a_portraitDenominator;
    CGFloat l_width = [IFAUIUtils screenBoundsSizeForCurrentOrientation].width * (l_numerator / l_denominator);
    return l_width;
}

+(BOOL)isIPad {
    return UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad;
}

+(BOOL)isIPhoneLandscape {
    return ![self isIPad] && [self isDeviceInLandscapeOrientation];
}

+(NSString*)resourceNameDeviceModifier {
    return [self isIPad] ? @"~ipad" : @"~iphone";
}

+(UIViewAutoresizing)fullAutoresizingMask {
    return UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
}

+(NSString*)menuBarButtonItemImageName {
    NSString *l_imageName = [[IFAUtils infoPList] objectForKey:@"IFAMenuButtonImage"];
    if (!l_imageName) {
        l_imageName = @"271-ThreeColumn.png";
    }
    return l_imageName;
}

+(UIImage*)menuBarButtonItemImage {
    if (!c_menuBarButtonItemImage) {
        return [UIImage imageNamed:[self menuBarButtonItemImageName]];
    }
    return c_menuBarButtonItemImage;
}

+(void)dismissSplitViewControllerPopover {
    UIWindow *l_window = [UIApplication sharedApplication].delegate.window;
    UIViewController *l_appRootViewController = l_window.rootViewController;
    if ([l_appRootViewController isKindOfClass:[IFASplitViewController class]]) {
        IFASplitViewController *l_splitViewController = (IFASplitViewController *)l_appRootViewController;
        [l_splitViewController.splitViewControllerPopoverController dismissPopoverAnimated:NO];
    }
}

+(void)setKeyWindowRootViewController:(UIViewController*)a_viewController{
    [self dismissSplitViewControllerPopover];
    [UIApplication sharedApplication].keyWindow.rootViewController = a_viewController;
}

+(void)setKeyWindowRootViewControllerToMainStoryboardInitialViewController {
    [self setKeyWindowRootViewController:[[[IFAApplicationDelegate sharedInstance] storyboard] instantiateInitialViewController]];
}

+(void)adjustImageInsetsForBarButtonItem:(UIBarButtonItem*)a_barButtonItem insetValue:(CGFloat)a_insetValue{
    UIEdgeInsets l_imageInsets = UIEdgeInsetsZero;
    l_imageInsets.top = a_insetValue;
    l_imageInsets.bottom = a_insetValue*-1;
    a_barButtonItem.imageInsets = l_imageInsets;
}

+(UIColor*)colorForInfoPlistKey:(NSString*)a_infoPlistKey{
    UIColor *l_color = nil;
    NSDictionary *l_colorDictionary = [[IFAUtils infoPList] objectForKey:a_infoPlistKey];
    if (l_colorDictionary) {
        CGFloat l_red = [[l_colorDictionary objectForKey:@"red"] floatValue];
        CGFloat l_green = [[l_colorDictionary objectForKey:@"green"] floatValue];
        CGFloat l_blue = [[l_colorDictionary objectForKey:@"blue"] floatValue];
        CGFloat l_alpha = [[l_colorDictionary objectForKey:@"alpha"] floatValue];
        l_color = [UIColor ifa_colorWithRed:l_red green:l_green blue:l_blue alpha:l_alpha];
    }
    return l_color;
}

+ (BOOL)isImageWithinSafeMemoryThresholdForSizeInPixels:(CGSize)a_imageSizeInPixels {
    CGFloat l_imageSizeInPixels = a_imageSizeInPixels.width * a_imageSizeInPixels.height;
    BOOL l_ok = l_imageSizeInPixels <= IFAMaximumImageSizeInPixels;
    return l_ok;
}

+ (UIEdgeInsets)tableViewCellDefaultSeparatorInset {
    return UIEdgeInsetsMake(0, 15, 0, 0);
}

+ (void)showServerErrorAlertViewForNetworkReachable:(BOOL)a_networkReachable
                                  alertViewDelegate:(id <UIAlertViewDelegate>)a_alertViewDelegate {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *l_title;
    NSString *l_messageArgument;
    if (a_networkReachable) {
        l_title= @"Server error";
        l_messageArgument = @" Please try again later.";
    }else{
        l_title= @"No Internet access";
        l_messageArgument = @" Please try again when you are back online.";
    }
    NSString *l_message = [NSString stringWithFormat:@"It was not possible to complete the operation.%@", l_messageArgument];
    [IFAUIUtils showAlertWithMessage:l_message title:l_title delegate:a_alertViewDelegate];
}

+ (CGFloat)heightForWidth:(CGFloat)a_width aspectRatio:(CGFloat)a_aspectRatio {
    return a_width / a_aspectRatio;
}

+ (CGFloat)widthForHeight:(CGFloat)a_height aspectRatio:(CGFloat)a_aspectRatio {
    return a_height * a_aspectRatio;
}

@end
