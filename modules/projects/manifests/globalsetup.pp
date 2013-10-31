class projects::globalsetup {
    include dropbox
    include skype
    include iterm2::stable
    include chrome
#    include eclipse::jee
    include mou
    include better_touch_tools
    include alfred

    include osx::finder::unhide_library
    class osx::finder::show_all_files {
        include osx::finder
        boxen::osx_defaults { 'Show all files':
            user => $::boxen_user,
            domain => 'com.apple.finder',
            key => 'AppleShowAllFiles',
            value => true,
            notify => Exec['killall Finder']
        }
    }
    include osx::finder::show_all_files

    include osx::dock::autohide
    include osx::software_update

    # set global ruby version
    class { 'ruby::global':
        version => '1.9.3-p448'
    }

    # set global nodejs version
    class { 'nodejs::global':
        version => 'v0.10.13'
    }

    nodejs::module{ ['grunt-cli', 'node-inspector']:
        node_version => 'v0.10.13'
    }

    package {
        [
            'tmux',
            'reattach-to-user-namespace',
            'readline',
            'z',
            'tree',
            'imagemagick',
            'tig',
            'wget'
        ]:
    }

    package {
        'GoogleJapaneseInput':
            source => 'http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg',
            provider => pkgdmg;
    }

    package {
        'zsh':
            install_options => [
                '--disable-etcdir'
            ]
    }

    package {
        'tomcat':
            install_options => [
                '--stable'
            ]
    }

    file_line { 'add zsh to /etc/shells':
        path    => '/etc/shells',
        line    => "${boxen::config::homebrewdir}/bin/zsh",
        require => Package['zsh'],
        before  => Osx_chsh[$::boxen_user];
    }

    osx_chsh { $::boxen_user:
        shell => "${boxen::config::homebrewdir}/bin/zsh";
    }
}
