//
//  DetailsViewController.m
//  iTunesSearch
//
//  Created by Rubens Gondek on 3/11/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "DetailsViewController.h"
#import "TableViewController.h"
#import "iTunesManager.h"
#import "Music.h"
#import "Filme.h"
#import "Podcast.h"
#import "Ebook.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize iRow, iSection, lblTitle, lblArt, lblPrice, imgCapa;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    iTunesManager *itManager = [iTunesManager sharedInstance];
    id obj = [[itManager.midias objectAtIndex:iSection] objectAtIndex:iRow];
    
    if ([obj isMemberOfClass:[Music class]]) {
        self.navigationItem.title = @"Música";
        Music *m = obj;
        [lblTitle setText:m.nome];
        [lblArt setText:m.artista];
        [imgCapa setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.img]]]];
        [lblPrice setText:[NSString stringWithFormat:@"Price U$ %@", m.price]];
    }
    else if ([obj isMemberOfClass:[Filme class]]) {
        self.navigationItem.title = @"Filme";
        Filme *f = obj;
        [lblTitle setText:f.nome];
        [lblArt setText:f.artista];
        [imgCapa setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:f.img]]]];
        [lblPrice setText:[NSString stringWithFormat:@"Price U$ %@", f.price]];
    }
    else if ([obj isMemberOfClass:[Podcast class]]) {
        self.navigationItem.title = @"Podcast";
        Podcast *p = obj;
        [lblTitle setText:p.nome];
        [lblArt setText:p.genero];
        [imgCapa setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:p.img]]]];
        [lblPrice setText:[NSString stringWithFormat:@"Price U$ %@", p.price]];
    }
    else if ([obj isMemberOfClass:[Ebook class]]) {
        self.navigationItem.title = @"Ebook";
        Ebook *e = obj;
        [lblTitle setText:e.nome];
        [lblArt setText:e.artista];
        [imgCapa setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:e.img]]]];
        [lblPrice setText:[NSString stringWithFormat:@"Price U$ %@", e.price]];
    }
    
}

@end
