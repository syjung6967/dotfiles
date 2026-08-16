# Local gitconfig examples

See [git-config](https://git-scm.com/docs/git-config#_conditional_includes) for more information.

## ~/.gitconfigs/.gitconfig
```gitconfig
[includeIf "gitdir:~/repository/A"]
	path = configA.inc
[includeIf "hasconfig:remote.*.url:https://example.com/**"]
	path = configB.inc
```

## ~/.gitconfigs/{config}.inc
```gitconfig
# Set the private key path (also available with public key path if the corresponding private key is present on ssh-agent)
[core]
	sshCommand = ssh -i ~/.ssh/...

# Set the private key path or public key prefixed with key::
[user]
	email = user@example.com
	signingKey = key::ssh-ed25519 AAAA...

# Or, disable the sign.
[commit]
	gpgSign = false
[tag]
	gpgSign = false
```
