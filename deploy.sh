#!/usr/bin/env bash

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
MESSAGE="Site rebuild $(date)"

msg() {
    printf "\033[1;32m :: %s\n\033[0m" "$1"
}

if [[ $(git status -s) ]]; then
    msg "The working directory is dirty, please commit or stash any pending changes"
    exit 1;
fi

msg "Removing the old website"
pushd public
git rm -rf *
popd

msg "Building the website"
hugo

echo "mikheev.me" >> public/CNAME

msg "Pushing the updated \`public\` folder to the \`master\` branch"
pushd public
git add *
git commit -m "$MESSAGE"
popd
git push origin master
