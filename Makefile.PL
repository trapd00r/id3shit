#!/usr/bin/perl
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'id3shit',
#    PMLIBDIRS => ['lib'],
    ABSTRACT => 'Less sucky commandline id3 editor',
    AUTHOR => 'Magnus Woldrich <trapd00r@trapd00r.se',
    EXE_FILES => ['bin/id3shit'],
    LICENSE => "GPLv2",
    MIN_PERL_VERSION => 5.000,
    PREREQ_PM => {
        'MP3::Info' => 0,
    },
);


