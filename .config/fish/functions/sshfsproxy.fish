function sshfsproxy -a remote volname mount
	sshfs -o auto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=$volname,ProxyCommand="nc -X 5 -x localhost:9999 %h %p" $remote $mount
end