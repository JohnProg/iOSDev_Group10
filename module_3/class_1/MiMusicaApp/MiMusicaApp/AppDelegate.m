//
//  AppDelegate.m
//  MiMusicaApp
//
//  Created by Diego Cruz on 31/03/14.
//  Copyright (c) 2014 Diego Cruz. All rights reserved.
//

#import "AppDelegate.h"
#import "Artista.h"
#import "Album.h"
#import "Cancion.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSUserDefaults *miDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![miDefaults objectForKey:@"seCargoPlist"]) {
        
        NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"ArtistasList" ofType:@"plist"];
        NSArray *artistasPlist = [NSArray arrayWithContentsOfFile:pathFile];
        
        for (NSDictionary *artistaDic in artistasPlist) {
            
            Artista *nuevoArtista = [Artista create];
            nuevoArtista.nombre = artistaDic[@"nombre"];
            nuevoArtista.fechaNacimiento = artistaDic[@"fechaNacimiento"];
            
            for (NSDictionary *albumDic in artistaDic[@"albumes"]) {
                Album *nuevoAlbum = [Album create];
                nuevoAlbum.titulo = albumDic[@"titulo"];
                nuevoAlbum.anho = albumDic[@"anho"];
                nuevoAlbum.cover = albumDic[@"cover"];
                nuevoAlbum.artista = nuevoArtista;
                
                for (NSDictionary *cancionDic in albumDic[@"canciones"]) {
                    Cancion *nuevaCancion = [Cancion create];
                    nuevaCancion.titulo = cancionDic[@"titulo"];
                    nuevaCancion.duracion = cancionDic[@"duracion"];
                    nuevaCancion.orden = cancionDic[@"orden"];
                    
                    nuevaCancion.album = nuevoAlbum;
                }
            }

        }
        
        [[IBCoreDataStore mainStore] save];
        
        
        [miDefaults setBool:YES forKey:@"seCargoPlist"];
    }
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
