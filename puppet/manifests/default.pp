Exec {
  path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

hiera_include('classes')

package { 'openssh-server': ensure => 'installed' }

service { 'sshd':
            ensure  => 'running',
            enable  => true,
            require => Package['openssh-server']
            }

augeas { 'sshd_config':
  context => '/files/etc/ssh/sshd_config',
  changes => [
    'set PrintMotd yes',
  ],
  require => Package['openssh-server'],
  notify  => Service['sshd'],
}

notify{'in default.pp': }
