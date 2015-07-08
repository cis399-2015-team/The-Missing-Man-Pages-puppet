#connor's instance

node ip-10-0-4-226 {
	include sshd
}

#node connor-trusty {
#}

#joey's instance
node ip-10-0-4-27 {
}
#puppetmaster (reed's instance)
node ip-10-0-4-230 {
	cron { "puppet update":
		command	=> "cd /etc/puppet && git pull origin master && echo 'Update occurred.'",
		user	=> root,
		minute	=> "*/5",
	}
}
