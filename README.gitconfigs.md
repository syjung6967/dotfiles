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
[user]
	email = user@example.com
	signingKey = key::ssh-ed25519 AAAA... # prefixed key or path
```
