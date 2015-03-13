//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Music.h"
#import "Podcast.h"
#import "Ebook.h"
#import "DetailsViewController.h"

@interface TableViewController () {
    NSArray *media;
    NSUserDefaults *user;
}

@end

@implementation TableViewController

@synthesize txtSearch, tableview, strSearch, buttonSearch, midias;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    self.navigationItem.title = @"iTunes";
    
    user = [NSUserDefaults standardUserDefaults];
    [user synchronize];
    
    strSearch = [user valueForKey:@"Init"];
    [self search];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.frame.size.width, 60)];
    [header setBackgroundColor:[UIColor redColor]];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 20)];
    [lblTitle setTintColor:[UIColor whiteColor]];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    [header addSubview:img];
    [header addSubview:lblTitle];
    if (section == 0) {
        [img setImage:[UIImage imageNamed:@"movie"]];
        [lblTitle setText:@"Filmes"];
        [header setBackgroundColor:[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1]];

    }
    else if (section == 1) {
        [img setImage:[UIImage imageNamed:@"music"]];
        [lblTitle setText:@"Músicas"];
        [header setBackgroundColor:[UIColor colorWithRed:0.5 green:1 blue:0.5 alpha:1]];
    }
    else if (section == 2) {
        [img setImage:[UIImage imageNamed:@"podcast"]];
        [lblTitle setText:@"Podcasts"];
        [header setBackgroundColor:[UIColor colorWithRed:0.9 green:0.5 blue:0.9 alpha:1]];
    }
    else if (section == 3) {
        [img setImage:[UIImage imageNamed:@"ebooks"]];
        [lblTitle setText:@"Ebooks"];
        [header setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1]];
    }
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    media = [[NSArray alloc] initWithArray:[midias objectAtIndex:indexPath.section]];
    
    Filme *filme;
    Music *music;
    Ebook *ebook;
    Podcast *pod;
    
    long row = [indexPath row];
    
    switch (indexPath.section) {
        case 0:
            filme = [media objectAtIndex:row];
            [celula.nome setText:filme.nome];
            [celula.price setText:[NSString stringWithFormat:@"Price U$ %@", filme.price]];
            [celula.artista setText:filme.artista];
            [celula.genre setText:filme.genero];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:filme.img]]]];
            break;
        case 1:
            music = [media objectAtIndex:row];
            [celula.nome setText:music.nome];
            [celula.price setText:[NSString stringWithFormat:@"Price U$ %@", music.price]];
            [celula.artista setText:music.artista];
            [celula.genre setText:music.genero];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:music.img]]]];
            break;
        case 2:
            pod = [media objectAtIndex:row];
            [celula.nome setText:pod.nome];
            [celula.price setText:[NSString stringWithFormat:@"Price U$ %@", pod.price]];
            [celula.artista setText:pod.pais];
            [celula.genre setText:pod.genero];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pod.img]]]];
            break;
        case 3:
            ebook = [media objectAtIndex:row];
            [celula.nome setText:ebook.nome];
            [celula.price setText:[NSString stringWithFormat:@"Price U$ %@", ebook.price]];
            [celula.artista setText:ebook.artista];
            [celula.genre setText:@"Livro"];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ebook.img]]]];
            break;
        default:
            break;
    }
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *dVC = [[DetailsViewController alloc] init];
    dVC.iRow = [indexPath row];
    dVC.iSection = [indexPath section];
    [self.navigationController pushViewController:dVC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (IBAction)btnSearch:(id)sender {
    strSearch = txtSearch.text;
    strSearch = [strSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [txtSearch resignFirstResponder];
    [user setObject:strSearch forKey:@"Init"];
    [user synchronize];
    [self search];
}

- (void)search{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:strSearch];
    [tableview reloadData];
}

@end
