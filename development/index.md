---
layout: default
title: Relax-and-Recover development
---

## Development
The Relax-and-Recover project uses Github for [source code management](https://github.com/rear),
issue tracking and this website.

Rear is fully developed with the bash language and we follow the [coding styling described on the rear wiki page](https://github.com/rear/rear/wiki/Coding-Style)


### Mailinglists
The Relax-and-Recover project offers three mailinglists:

 - [rear-announce mailinglist](http://lists.relax-and-recover.org/mailman/listinfo/rear-announce)
   used for release announcements
 - [rear-users mailinglist](http://lists.relax-and-recover.org/mailman/listinfo/rear-users)
   used for end-user support
 - [rear-devel mailinglist](http://lists.relax-and-recover.org/mailman/listinfo/rear-devel)
   used for development discussions


### Reporting issues
The Github interface enables users to report issues or discuss improvements
and new features through the issue-tracker at:
<http://github.com/rear/rear/issues>

Once reported, one of the contributors can assign it to someone, classify it
and attached it to a milestone release. Managing issues in this manner helps
in collaborating, but also provides full transparency to users and contributors
alike.


### Release planning
New releases are planned based on outstanding issues, new features and ongoing
development. You can get an overview of the various milestones the project has
defined and you can influence new releases by reporting issues and by
contributing fixes at: <https://github.com/rear/rear/milestones>


### Contributing
If you are interested in contributing to Relax-and-Recover, you can discuss
your area of interest on the users mailinglist, or you can simply fork the
project on Github, make the modifications and then do a pull-request.

In your browser, navigate to <https://github.com/rear/rear>

Fork this repository by clicking the Fork button on the upper right-hand side. A fork of the repository is generated for you. On the right-hand side of the page of your fork, under 'Clone with HTTPS' or 'Clone with SSH', copy the URL by clicking the Copy to clipboard icon.

This makes it easy for the project to discuss the changes through the
pull-request, and when accepted to merge the pull-request into the project.

On your computer, follow these steps to setup a local repository to start working on the forked sources of ReaR (in following example we use the 'Clone with SSH' output):

    $ git clone git@github.com:YOURNAME/rear.git
    $ cd rear

Add a remote for the upstream repository:

    $ git remote add upstream git@github.com:rear/rear.git
    $ git checkout master
    $ git fetch upstream
    $ git merge upstream/master

Create a new topic branch for the changes you want to make, based on the *master* branch from upstream:

    $ git checkout -b fix-4-issue-999   upstream/master

Make your changes, test them, commit them and push them to Github:

    $ git commit -a -m 'describe what you modified'
    $ git push origin fix-4-issue-999

Open a Pull request from `YOURNAME:fix-4-issue-999` to `rear:master`.

If you want to open another pull request for another change which is independant of the previous one, just create another topic branch based on the *master* branch from upstream ( `git checkout -b fix-4-issue-999-2 upstream/master` )

Finally, you can remove your branch `fix-4-issue-999` when it has been merged in the `rear:master` branch.

    $ git checkout master
    $ git branch -D fix-4-issue-999

Merging the upstream/master with your local branch is important to maintain an up-to-date master branch in your local repository. Merge the changes on a daily basis from the upstream/master (the official ReaR repository) into your local repository.

Ensure that you do complete this activity before you start working on a feature as well as right before you submit your changes as a pull request.

You can also do this process periodically while you work on your changes to make sure that you are working off the most recent version of the sources of ReaR.

    # Checkout your local 'master' branch.
    $ git checkout master
    
    # Synchronize your local repository with 'upstream/master', so that you have all the latest changes.
    $ git fetch upstream
    
    # Merge the latest changes from the 'upstream/master' into your local 'master' branch to make it up-to-date.
    $ git merge upstream/master
    
    # Checkout your local development branch (e.g.: 'dev').
    $ git checkout dev
    
    # Pull the latest changes into your local development branch.
    $ git pull master
    
If you want to keep a fork, see also [this article](https://2buntu.com/articles/1459/keeping-your-forked-repo-synced-with-the-upstream-source/) for an illustrated guide to keep your forked repo in sync.

### Sponsoring
We have a list of missing features that were requested but never got to a point
of being implemented by the team members. If you feel an urgent need to see a
missing feature added not hesitate to [sponsor us in the ways listed](http://relax-and-recover.org/support/sponsors)

### Professional services
If your company requires integrating Relax-and-Recover into their DRP setup or
is interested to sponsor certain development, this is possible by the following
companies that offer development services:

 - [IT3 Consultants](http://www.it3.be/) (owner: Gratien D'haese)
   * [Rear Support Services offered by IT3 Consultants](http://www.it3.be/rear-support/)
 - [Schlomo Schapiro](http://consulting.schlomo.schapiro.org/)

The various contributors have invested a lot in the creation and support
of Relax-and-Recover.
