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
}

@end

@implementation TableViewController

@synthesize txtSearch, tableview, strSearch, buttonSearch, midias;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    self.navigationItem.title = @"iTunes";
    
    strSearch = @"SpongeBob";
    [self search];
    
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if ([language isEqualToString:@"en"]) {
        [buttonSearch setTitle:@"Search" forState:UIControlStateNormal];
    }
    else if([language isEqualToString:@"pt"]){
        [buttonSearch setTitle:@"Buscar" forState:UIControlStateNormal];
    }
    else if([language isEqualToString:@"fr"]){
        [buttonSearch setTitle:@"Recherche" forState:UIControlStateNormal];
    }
    
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return @"Filmes";
        case 1: return @"Musicas";
        case 2: return @"Podcasts";
        case 3: return @"Ebooks";
    }
    
    return @"Deu RUIM!";
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
            //[celula.price setText:(NSString*)music.price];
            [celula.artista setText:filme.artista];
            [celula.genre setText:filme.genero];
            [celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:filme.img]]]];
            break;
        case 1:
            music = [media objectAtIndex:row];
            [celula.nome setText:music.nome];
            //[celula.price setText:(NSString*)music.price];
            [celula.artista setText:music.artista];
            [celula.genre setText:music.genero];
            //[celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:music.imagem]]]];
            break;
        case 2:
            pod = [media objectAtIndex:row];
            [celula.nome setText:pod.nome];
            [celula.price setText:@"Podcast"];
            [celula.artista setText:pod.pais];
            [celula.genre setText:pod.genero];
            //[celula.img setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pod.img]]]];
            break;
        case 3:
            ebook = [media objectAtIndex:row];
            [celula.nome setText:ebook.nome];
            [celula.price setText:@"Ebook"];
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
    [self search];
}

- (void)search{
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:strSearch];
    [tableview reloadData];
}

@end
