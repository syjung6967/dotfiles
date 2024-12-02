Local gitconfig examples

## ~/.gitconfigs/.gitconfig
```
[includeIf "gitdir:~/repository/A"]
    path = A.gitconfig
[includeIf "gitdir:~/repository/B"]
    path = B.gitconfig
```

## ~/.gitconfigs/{config}.gitconfig
```
[user]
	email = user@example.com
	signingKey = key::ssh-ed25519 AAAA... # prefixed key or path
```
