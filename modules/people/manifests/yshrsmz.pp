class people::yshrsmz {
    $home = "/Users/${::luser}"
    $opt = "${home}/opt"
    $dotfiles = "${opt}/dotfiles"
    $dust = "${home}/.dust"

    repository { $dotfiles:
        source => "yshrsmz/dotfiles",
        require => File[$opt]
    }

    exec { "sh ${dotfiles}/setup.sh":
        cwd => $dotfiles,
        require => Repository[$dotfiles]
    }

#    exec { "gem install bundler":
#        cwd => $home
#        require => Repository[$dotfiles]
#    }

    exec { "bundle install":
        cwd => $dotfiles,
        require => Repository[$dotfiles]
    }

}
