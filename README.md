# redteamatmtu.github.io
The website for RedTeam@MTU located at https://www.redteam.mtu.edu

## About the RedTeam Website

This website uses [Hugo](https://gohugo.io/), a [Static Site Generator (SSG)](https://www.cloudflare.com/learning/performance/static-site-generator/).

The theme was modified from [Academia-Hugo](https://github.com/gethugothemes/academia-hugo).

The website used to be hosted by the [Linux Users Group@MTU](https://lug.mtu.edu), but as of April 2026 the website has been moved to [GitHub Pages](https://pages.github.com/).

Meeting Minutes go in `content/minutes/<date>.md`. You can copy an existing Meeting Minutes to use as a base, or use the helper script at `scripts/start_new_minutes.sh` to automate some of the tedium.

If you are new to Git, the general process to clone a copy of the website to your device goes as follows (assuming a *NIX device, Windows users good luck):

If you don't have the repository on your device yet, run:

1. `git clone https://github.com/RedTeamAtMTU/redteamatmtu.github.io`

Once you have a copy of the repository downloaded, you can follow the following procedure for all changes you make to the website:
1. `cd redteamatmtu.github.io`
2. `git pull` (pull any changes from GitHub to our local copy, in case someone pushed a change from the last time we `clone`/`pull`ed the repository)
3. <create/edit files>
4. `hugo server` (to make sure the site still builds, and open the localhost URL in your browser to make sure the content looks correct)
5. `git add .` (stage all changes)
6. `git commit -m "<simple message about what you changed>"` (commit all changes in the local repository)
7. `git push` (push the contents of the local repository to GitHub)

Ensure you are using Hugo v0.159.1 or higher to build the site on your local machine while testing, as older versions can fail to build the site properly.
