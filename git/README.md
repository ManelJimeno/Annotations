# Cheat sheet for git

* Tags

``` bash
# Create a tag and push it
git tag -a v1.0 -m "Version 1.0"
git push origin v1.0 -f

# Delete a tag local and remotely
git tag -d v1.0
git push origin --delete v1.0

```
* [Git Rebase... with Merges?](https://jnielson.com/git-rebase-with-merges)
* [Create a local repository and connect it to a remote one](create_and_connect.sh)
* [Replaces the author on the entire specified branch](git_replace_author.sh)
