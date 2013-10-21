class people::yshrsmz {
    $home = "/Users/${::luser}"
    $src = "${home}/src"
    $dotfiles = "${src}/dotfiles"
    $dust = "${home}/.dust"

    repository { $dotfiles:
        source => "yshrsmz/dotfiles",
        require => File[$src]
    }

    exec { "sh ${dotfiles}/setup.sh":
        cwd => $dotfiles,
        require => Repository[$dotfiles]
    }

    exec { "gem install bundler":
        cwd => $home
        require => Repository[$dotfiles]
    }

    exec { "bundle install":
        cwd => $dotfiles,
        require => Repository[$dotfiles]
    }

}