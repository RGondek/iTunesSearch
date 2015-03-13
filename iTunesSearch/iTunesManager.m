//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Music.h"
#import "Ebook.h"
#import "Podcast.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *musics = [[NSMutableArray alloc] init];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];
    
    NSString *tipo;
    
    for (NSDictionary *item in resultados) {
        tipo = [item objectForKey:@"kind"];
        if ([tipo isEqualToString:@"feature-movie"]) {
            Filme *filme = [[Filme alloc] init];
            [filme setNome:[item objectForKey:@"trackName"]];
            [filme setTrackId:[item objectForKey:@"trackId"]];
            [filme setArtista:[item objectForKey:@"artistName"]];
            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPais:[item objectForKey:@"country"]];
            [filme setImg:[item objectForKey:@"artworkUrl100"]];
            //[filme setPrice:[item objectForKey:@"trackPrice"]];
            [filmes addObject:filme];
            
        }
        else if ([tipo isEqualToString:@"song"]){
            Music *music = [[Music alloc] init];
            [music setNome:[item objectForKey:@"trackName"]];
            [music setTrackId:[item objectForKey:@"trackId"]];
            [music setArtista:[item objectForKey:@"artistName"]];
            [music setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [music setGenero:[item objectForKey:@"primaryGenreName"]];
            [music setPais:[item objectForKey:@"country"]];
            //[music setPreview:[item objectForKey:@"previewUrl"]];
            //[music setPrice:[item objectForKey:@"trackPrice"]];
            [musics addObject:music];
        }
        else if ([tipo isEqualToString:@"ebook"]){
            Ebook *ebook = [[Ebook alloc] init];
            [ebook setNome:[item objectForKey:@"trackName"]];
            [ebook setTrackId:[item objectForKey:@"trackId"]];
            [ebook setArtista:[item objectForKey:@"artistName"]];
            [ebook setImg:[item objectForKey:@"artworkUrl100"]];
            //[ebook setPrice:[item objectForKey:@"trackPrice"]];
            [ebooks addObject:ebook];
        }
        else if ([tipo isEqualToString:@"podcast"]){
            Podcast *pod = [[Podcast alloc] init];
            [pod setNome:[item objectForKey:@"trackName"]];
            [pod setTrackId:[item objectForKey:@"trackId"]];
            [pod setGenero:[item objectForKey:@"primaryGenreName"]];
            [pod setPais:[item objectForKey:@"country"]];
            //[pod setImg:[item objectForKey:@"artworkUrl100"]];
            //[pod setPrice:[item objectForKey:@"trackPrice"]];
            [podcasts addObject:pod];
        }
    }
    
    _midias = [[NSArray alloc] initWithObjects:filmes, musics, podcasts, ebooks, nil];
    
    return _midias;
}


#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
