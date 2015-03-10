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

@interface TableViewController () {
    NSArray *midias;
}

@end

@implementation TableViewController

@synthesize txtSearch, tableview, strSearch, buttonSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    
    strSearch = @"Apple";
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula.genre setText:filme.genero];
    
    
    return celula;
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
