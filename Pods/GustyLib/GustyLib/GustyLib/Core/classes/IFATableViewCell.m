//
//  IFATableViewCell.m
//  Gusty
//
//  Created by Marcelo Schroeder on 12/10/10.
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


@implementation IFATableViewCell {
    
}


#pragma mark - Public

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier object:(NSObject*)a_object propertyName:(NSString*)a_propertyName{
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier object:a_object propertyName:a_propertyName indexPath:nil];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier object:(NSObject*)a_object propertyName:(NSString*)a_propertyName indexPath:(NSIndexPath*)a_indexPath{
    if ((self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.object = a_object;
        self.propertyName = a_propertyName;
        self.indexPath = a_indexPath;
    }
    return self;
}

#pragma mark - Overrides

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    return [[super initWithStyle:style reuseIdentifier:reuseIdentifier] ifa_init];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return [[super initWithCoder:aDecoder] ifa_init];
}

-(void)awakeFromNib{
    [self ifa_awakeFromNib];
}

-(void)willTransitionToState:(UITableViewCellStateMask)state{
    [super willTransitionToState:state];
//    NSLog(@"willTransitionToState: %u", state);
    self.swipedToDelete = (state == UITableViewCellStateShowingDeleteConfirmationMask);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self ifa_prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [[self ifa_appearanceTheme] setAppearanceOnSetSelectedForCell:self animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [[self ifa_appearanceTheme] setAppearanceOnSetHighlightedForCell:self animated:animated];
}

@end
