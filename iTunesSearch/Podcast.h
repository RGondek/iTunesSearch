//
//  Podcast.h
//  iTunesSearch
//
//  Created by Rubens Gondek on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Podcast : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;

@end
