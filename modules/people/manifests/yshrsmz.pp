class people::yshrsmz {
    $home = "/Users/${::luser}"
    $src = "${home}/src"
    $dotfiles = "${home}/dotfiles"
    $dust = "${home}/.dust"

#    file { $src:
#        ensure => "directory"
#    }
    repository { $dotfiles:
        source => "yshrsmz/dotfiles",
        require => File[$src]
    }

    exec { "sh ${dotfiles}/setup.sh ${dotfiles}":
        cwd => $dotfiles,
        require => Repository[$dotfiles]
    }

    $version = "1.9.3-p448"
    ruby::gem { "tmuxinator for ${version}":
        gem => 'tmuxinator',
        ruby => $version,
    }

#    exec { "gem install bundler":
#        cwd => $home
#        require => Repository[$dotfiles]
#    }

#exec { "bundle install":
#        cwd => $dotfiles,
#        logoutput => true,
#        require => Repository[$dotfiles]
#    }

}
