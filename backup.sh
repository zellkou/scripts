#!/bin/bash

# rsync backup function
sync(){
# -r recursive -u update -i itemize -p permissions -o owner -g group
    rsync -ruipog --delete --ignore-existing /plex/Movies/Bio-Pics/ /Backup/Bio-Pics &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Classics/ /Backup/Classics &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Documentaries/ /Backup/Documentaries &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Fantasy/ /Backup/Fantasy &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Harry-Potter/ /Backup/Harry-Potter &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Movies/ /Backup/Movies &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Musicals/ /Backup/Musicals &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Superhero/ /Backup/Superhero &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/SciFi/ /Backup/SciFi &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/Star-Wars/ /Backup/Star-Wars &&
    rsync -ruipog --delete --ignore-existing /plex/Movies/War/ /Backup/War &&
    rsync -ruipog --delete --ignore-exisitng /plex/Movies/Westerns/ /Backup/Westerns &&
    rsync -ruipog --delete --ignore-existing /plex/TV/TVShows/ /Backup/TVShows &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/Anime/ /Backup/Anime &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/AnimeTV/ /Backup/AnimeTV &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/Cartoons/ /Backup/Cartoons &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/CartoonTV/ /Backup/Cartoon/TV &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/DC/ /Backup/DC &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/Scooby-Doo/ /Backup/Scooby-Doo &&
    rsync -ruipog --delete --ignore-existing /plex/Animated/Scooby-Doo-TV/ /Backup/Scooby-Doo-TV &&
    rsync -ruipog --delete --ignore-existing /plex/Other/Adult/ /Backup/Adult &&
    rsync -ruipog --delete --ignore-existing /plex/Other/audiobooks/ /Backup/audiobooks &&
    rsync -ruipog --delete --ignore-existing /plex/Other/asmr/ /Backup/asmr &&
    rsync -ruipog --delete --ignore-existing /plex/Other/books/ /Backup/books &&
    rsync -ruipog --delete --ignore-existing /plex/Other/Libraries/ /Backup/Libraries &&
    rsync -ruipog --delete --ignore-existing /plex/Other/Music/ /Backup/Music &&
}

# Check if drive is already mounted > to null so it doesn't print the result
if mount | grep /Backup > /dev/null; then
# Run Sync function
    sync() &&
# Unmount Backup
    umount /Backup
else
# Find sdx of external drive
    i=$(file /dev/disk/by-uuid/4bfb578b-f411-498a-8bac-aea04a256b4d | cut -c 80-)
# Mount Backup drive
    mount /dev/$i /Backup &&
# Run Sync function
    sync() &&
# Unmount Backup
    umount /Backup
fi
