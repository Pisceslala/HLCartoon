//
//  HLBaseHeader.m
//  HLCartoon
//
//  Created by Pisces on 2017/7/18.
//  Copyright © 2017年 Pisces. All rights reserved.
//

#import "HLBaseHeader.h"

@interface HLBaseHeader ()

@property (weak, nonatomic) IBOutlet UILabel *title_Label;


@end

@implementation HLBaseHeader

+ (instancetype)showBaseHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"HLBaseHeader" owner:nil options:nil] lastObject];
}

- (void)setSuggestionModel:(HLSuggestionModel *)suggestionModel {
    _suggestionModel = suggestionModel;
    
    self.title_Label.text = suggestionModel.title;
}



@end
