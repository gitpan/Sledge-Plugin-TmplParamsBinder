use ExtUtils::MakeMaker;
WriteMakefile(
        'NAME'         => 'Sledge::Plugin::TmplParamsBinder',
        'VERSION_FROM' => 'lib/Sledge/Plugin/TmplParamsBinder.pm', # finds $VERSION
        'PREREQ_PM'    => {
                Test::More => 0.32,
                PadWalker  => 1.0,
        },
);
