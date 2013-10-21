class project::globalsetup {
    include osx
    include dropbox
    include skype
    include iterm2::stable
    include chrome

    include osx::finder::unhide_library
    class osx::finder::show_all_files {
        include osx::finder
        boxen::osx_defaults { 'Show all files'
            user => $::luser
            domain => 'com.apple.finder',
            key => 'AppleShowAllFiles',
            value => true,
            notify => Exec['Killall Finder']
        }
    }
    include osx::finder::show_all_files

    include osx::dock::autohide

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
        ]
    }

    package {
        'Mou':
            source => 'http://mouapp.com/download/Mou.zip',
            provider => compressed_app
        'GoogleJapaneseInput':
            source => 'http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg'
            provider => pkgdmg
    }

    package {
        'zsh':
            install_options => [
                '--disable-etcdir'
            ]
    }

    file_line { 'add zsh to /etc/shells':
        path    => '/etc/shells',
        line    => "${boxen::config::homebrewdir}/bin/zsh",
        require => Package['zsh'],
        before  => Osx_chsh[$::luser];
    }

    osx_chsh { $::luser:
        shell => "${boxen::config::homebrewdir}/bin/zsh";
    }
}