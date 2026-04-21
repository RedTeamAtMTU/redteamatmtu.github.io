# redteamatmtu.github.io

The website for the RedTeam at [Michigan Technological University](https://www.mtu.edu/) located at https://www.redteam.mtu.edu/.

## About the RedTeam Website

This website uses [Hugo](https://gohugo.io/), a [Static Site Generator (SSG)](https://www.cloudflare.com/learning/performance/static-site-generator/).

The theme was modified from [Academia-Hugo](https://github.com/gethugothemes/academia-hugo).

The website used to be hosted by the [Linux Users Group@MTU](https://lug.mtu.edu), but as of April 2026 the website has been moved to [GitHub Pages](https://pages.github.com/).

## Working on the Website

If you are new to Git, the general process to clone a copy of the website to your device goes as follows (assuming a *NIX device, Windows users good luck):

If you don't have the repository on your device yet, run:

`git clone https://github.com/RedTeamAtMTU/redteamatmtu.github.io`

Once you have a copy of the repository downloaded, you can follow the following procedure for all changes you make to the website:
1. `cd redteamatmtu.github.io`
2. `git pull` (pull any changes from GitHub to our local copy, in case someone pushed a change from the last time we `clone`/`pull`ed the repository)
3. <create/edit files>
4. `hugo server` (to make sure the site still builds, and open the localhost URL in your browser to make sure the content looks correct)
5. `git add .` (stage all changes)
6. `git commit -m "<simple message about what you changed>"` (commit all changes in the local repository)
7. `git push` (push the contents of the local repository to GitHub)

Ensure you are using [Hugo v0.159.1](https://github.com/gohugoio/hugo/releases/tag/v0.159.1) or higher to build the site on your local machine while testing, as older versions can fail to build the site properly.

## Changing Hero Section

The "hero" section is the section currently at the top of the website (though this section, and all others on the homepage, can be freely re-arranged by modifying their `weight` value in their respective `.md` files.

If you wish to change the contents of this section, you can edit `content/home/hero.md`.

## Meeting Schedule for Each Semester

The integrated countdown for each meeting is based on the dates in `content/home/meetings.md`. It may be possible the timer has a hardcoded assumption it is Daylight Savings Time. This can either be properly fixed by fixing the logic of `getTimeRemaining()` in `themes/academia-hugo/assets/js/academia.js`, or just change the `meeting_time` in `content/home/meetings.md` to be an hour earlier while in Standard Time, and update it when Daylight Savings Time kicks in each year.

The Google Calendar link is `calendar_url` in `config/_default/params.toml`. To generate a calendar link for the meetings, make a reoccurring event in your personal Google Calendar, click "share", and copy the link (and replace it as the value of `calendar_url` in `config/_default/params.toml`).

Generally updating the integrated countdown and Google Calendar link should only need to be done once per semester (or year, if you calculate the meetings and breaks far ahead of time). This should generally be the responsibility of the Secretary.

## Eboard Officers

All officers listed on the homepage can be modified by editing `content/home/officers.md`. This includes one of our advisors (Dr. Yu Cai), and should be modified at some point to also include Dr. Bo Chen as well (RedTeam has two advisors, however there is a hardcoded assumption we have one advisor in the template).

Each officer can optionally be linked to a "officers" page (a Hugo "Author"), if they want a place to put related links, contact methods, or more information about themselves.

You can make an "Officers" page for someone by creating a directory `content/officers/<username>/`, where `<username>` can be anything (though sticking to MTU usernames may make things easier). From there, you need to make `content/officers/<username>/_index.md`. You can copy over `content/officers/noahholl/_index.md` to the new officer's directory as a starting point to work off.

Even after someone's eBoard tenure has expired, keep their "officer" page if they authored any posts, as otherwise the site will fail to build (and to preserve the history of who made posts).

## Making New Posts

Posts are created by making a directory in `content/posts/<post_name>/`. The `<post_name>` will be used as the URL for the post on the website. For example, `defcon33` becomes `https://www.redteam.mtu.edu/posts/defcon33/`.

After making the directory, you must make an `index.md` inside the post's directory containing the text of the post, and where you want the gallery of pictures to be placed in the post (usually at the bottom).

After the `index.md`, choose an image (the 'featured' image) to represent the post on the homepage and embeds (such as if someone sends a link to the post in Discord) and name it `featured.jpg` or `featured.png` (depending on the image type).

Finally, images for the post's gallery are stored in `gallery/` inside the post's directory.

You can use `content/posts/defcon33/` as a reference, when authoring a new post.

It is generally a good idea to make a post for each conference or event RedTeam attends, so be sure to take pictures while you're there!

## Meeting Minutes

Meeting Minutes go in `content/minutes/<YYYY-MM-DD>.md`.

You can copy an existing Meeting Minutes to use as a base, or use the helper shell script at `scripts/start_new_minutes.sh` to automate some of the tedium.

If there is a URL for the presentation shown at the meeting that night (such as on someone's personal site or on Google Drive), you can add it to the "links" section in the respective minutes for that meeting, and have a button link to it so people can find it more easily.

An example of a meeting minutes with a presentation link is [here](https://www.redteam.mtu.edu/minutes/2025-04-03/), if you wanted to see what it will look like.

You have a choice of any icons included in FontAwesome 5 Free (same goes for any icons across the entire site). You can go to the [FontAwesome website](https://fontawesome.com/v5/search?ic=free-collection) to search for all icons available in the pack, so you can select the best one for the resource (such as Google Drive logo, SoundCloud logo, a generic "link", etc).

## Adding Accomplishments

Accomplishments can be added/changed on the homepage by editing `content/home/accomplishments.md`
