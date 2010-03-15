#!/usr/bin/perl 
# id3shit - Commandline based id3 editor that sucks less
# Copyright (C) 2010 trapd00r <trapd00r@trapd00r.se>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;

use MP3::Info;
use MP3::Info qw(:genres);
use Getopt::Long;

my $APPLICATION_NAME = 'id3shit';
my $APPLICATION_VERSION = '2.0';

my $mp3 = MP3::Info->new;

our ($read_tags,$read_info, $remove, @write, $genres);

GetOptions('read_tags'  =>  \$read_tags,
           'read_info'  =>  \$read_info,
           'remove'     =>  \$remove,
           'write=s{2}' =>  \@write,
           'genres'     =>  \$genres,
           );

my @files = @ARGV;
if(!@ARGV) {
  &help;
}
if($read_tags) {
  &read_tags(@files);
}
if($read_info) {
  &read_info(@files);
}
if($remove) {
  &remove_tags(@files);
}
if(@write) {
  &write_tags(@files);
}
if($genres) {
  &show_genres;
}

sub show_genres {
  foreach my $genre(sort(keys(%mp3_genres))) {
    printf("% 2s | %0s\n", $mp3_genres{$genre}, $genre);
  }
  printf("----------\n\033[31;1m%0s \033[0m|\033[31;1m %0s\033[0m\n",
        'NO', 'NAME');
  exit 0;
}

sub write_tags {
  my @f_to_write = @_;
  foreach my $file(@files) {
    my $tags = get_mp3tag($file, 1);
    $tags->{uc($write[0])}=ucfirst($write[1]);
    
    set_mp3tag($file, $tags);
    &read_tags($file);
  }
  exit 0;
}


sub remove_tags {
  my @f_to_fuckup = @_;
  foreach my $file(@f_to_fuckup) {
    print 'Removed ', remove_mp3tag($file, 'ALL'), "bytes\n";
  }
  exit 0;
}

sub read_tags {
  my @f_to_read = @_;
  foreach my $file(@f_to_read) {
    my $tags = get_mp3tag($file, 1);

    printf("%11s : %0s\n", 'FILE', "\033[31;1m$file\033[0m");                  
    while(my($key,$value) = each %$tags) {
      printf("%11s : %0s\n", $key, $value);
    }
    print "\n";
  }
  exit 0;
}

sub read_info {
  my @f_to_operate = @_;
  foreach my $file(@f_to_operate) {
    my $info = get_mp3info($file);

    printf("%12s : %0s\n", 'FILE', "\033[31;1m$file\033[0m");
    while(my($key,$value) = each %$info) {
      printf("%12s : %0s\n", $key, $value);
    }
    print "\n";
  }
  exit 0;
}

sub help {
  print << "HLEP";
  $APPLICATION_NAME $APPLICATION_VERSION
  USAGE: $0 [OPTIONS] <FILES>

  OPTIONS:
    -t  --tags    Show ID3V{1,2} tags
    -i  --info    Show audio information
    -r  --remove  Remove known tags
    -w  --write   Write tags. The syntax is --write FIELD VALUE FILE
                  Legal fields are ARTIST, ALBUM, TITLE, YEAR, COMMENT,
                  TRACKNUM, GENRE.

                  Examples:
                  --write artist laleh *.mp3
                  Will give us something like:
                  >> ARTIST: Laleh
HLEP
}
