class sendmail-reed {
	package {
		"sendmail": ensure => installed;
	}
	package {
		"sendmail-cf": ensure => installed;
	}

	file {"/etc/mail/sendmail.conf":
		notify	=> Service["sendmail"],
		mode 	=> 644,
		owner	=> "root",
		group	=> "root",
		source	=> "puppet:///modules/sendmail-reed/sendmail.conf",
		require	=> Package["sendmail"],
	}

	service {"networking":
		enable	=> true,
		ensure	=> running,
	}


	file { "/etc/mail/sendmail.mc":
		mode   => 644,
		owner  => "root",
		group  => "smmsp",
		source => "puppet:///modules/sendmail-reed/sendmail.mc",
		notify => [ Exec["/usr/bin/make -C /etc/mail"],
			    Service["sendmail"] ],
	}

	exec {"/usr/bin/make -C /etc/mail":
              refreshonly => true,
              require     => Package["sendmail-cf"],
	}

	file { "/etc/mail/local-host-names":
		mode   => 644,
		owner  => "root",
		group  => "smmsp",
		source => "puppet:///modules/sendmail-reed/local-host-names",
		notify => Service["sendmail"],
	}

	service { "sendmail":
		enable => true,
		ensure => running,
		require => Package["sendmail"],
	}
}
