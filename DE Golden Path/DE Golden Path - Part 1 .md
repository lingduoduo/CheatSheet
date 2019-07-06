

## Part 1

Introduction[¶](https://backstage.spotify.net/docs/data-engineering-golden-path/part-1-configuring-your-local-development-environment/1-introduction/#introduction)

This first part of the Data Engineering Golden Path tutorial takes you through the process of getting access to our development services and production hosts, and explains how you install and configure a standard set of local development tools.

**We recommend that you complete this tutorial before proceeding with other tutorials in this series.** (We have tested all our tutorials on clean machines that have been set up according to the instructions given here.)

General support with this Golden Path is offered on the [#data-support](https://spotify.slack.com/messages/C047H3XMT/) channel in Slack and through the [data](https://spotify.stackenterprise.co/questions/tagged/data) tag on Stack Enterprise.

Gettting access to our networks
Internal Services network¶
To get access to our Internal Services network, follow the instructions that have already been sent to you by IT Services. Contact IT Services (helpdesk | email | slack) if you have any trouble connecting to the Internal Services network.

Access group memberships¶
When you started at Spotify, your manager should have provided you with a list of LDAP groups to which you need to belong, and you should have submitted an IT ticket requesting you be added to these groups. You'll need to be a member of the following Spotify access groups:

dev
tech
backend
<your-squad> (e.g. dataex)

To check your access group memberships, go to Backstage and log in.
Click your profile picture in the main toolbar.
If prompted to do so, sign in to your Google account using your normal Spotify credentials.

Select the Squads and LDAP Groups menu option. A new window will open, showing you all the squads and LDAP groups you belong to.

Make sure that all the access groups above appear in the lists.

Joining an access group
Spotify Private Network (VPN) access through FortiClient¶
If you wish to reach production servers and also many of our development systems like GHE from outside the office (i.e., outside the Spotify private WiFi or wired internal network in supported offices), you need access to the Spotify Private Network (not to be confused with the "Spotify Internal Services" network, above: see this visualisation over the different network access levels). Private Network access is also needed to get to the Spotify brew tap, Maven .m2/settings and artifacts.

image alt text

FortiClient is our recommended VPN client. It is usually pre-installed on Spotify laptops. If not so, install it by following the instructions in this Confluence article:

VPN
Click the Mac OS X link and find the section headed Connect using FortiClient on Mac.

Important! If you try to use OS X's built-in VPN client you will run into difficulties: the DNS resolvers do not update properly, which means you will be forced to set the DNS settings manually every time you connect to the VPN. Save yourself some pain: use FortiClient.

SSH key¶
To get access to the Spotify production hosts and to access GHE you will need to use SSH authentication.

Generate a new SSH key by following the instructions in the SSH article in the IT Support Knowledge Base. By default, your SSH keys are stored in your local ~/.ssh folder.
When you have generated your public key, do the following:
Upload it to Authenticator
Upload it to GitHub Enterprise
Add the key to SSH on your laptop by entering the following command in your Terminal:
`
$ ssh-add -K ~/.ssh/id_rsa # -K does not apply on Linux
`
Note
Mac OS Sierra: The -K flag means that your passphrase for the given identity will be stored in the Mac OS keychain. To avoid having to do this on every boot in Mac OS Sierra, see here.
Note
Whenever we show you a command to be entered in these tutorials, we always represent the current prompt as "$". You do not need to enter this character with the command string.
Check the troubleshooting section at the bottom of the Knowledge Base article linked above: it will help you if you run into any issues later on. It takes about 30 minutes to set up SSH authentication. In the meantime, continue with these instructions until you get to the steps that require SSH.
OS X account name vs Spotify username
When you have authenticated access (it might take up to 30 minutes), you might want to verify that you can reach our production hosts (optional):
If you are connecting to the Spotify network remotely, (i.e., from outside the office) start FortiClient to get access to the Spotify Private Network.
Run the following command in a Terminal window:
`
$ ssh devadmin.roles.guc3.spotify.net
`
If you get the message "The authenticity of host ... can't be established. Are you sure you want to continue connecting?", enter yes.
If you have successfully connected to the host, your prompt should now look similar to:
<your-username>@guc3-devadmin-a-xxxx:~$
Log out from the remote host with:
<your-username>@guc3-devadmin-a-xxxx:~$ exit

Installing the Standard toolkit
Note
If you have been with us for some time, you may already have some of these tools in your laptop. However, if you work with backend development or follow the Golden Path tutorials, we strongly recommend that you update all your tools to the latest versions.

Homebrew and Command Line Tools¶
Homebrew is a package manager for OS X. You'll need it to install other Spotify software.
Install it from here. For security purposes, make sure the command looks like this.
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Git¶
Git is the version control system used at Spotify. An older version is preinstalled on Macs, but we recommend that you get a new version via Homebrew.
Install from your Terminal:
$ brew install git
Tip
Installing git with brew (instead of using the OS installation) on Mojave defaults to use the locale language. So if you are in Sweden, it will be in Swedish. To override this, put this line in your .bash_profile:

alias git='LC_ALL en git'

Configure git with your name and email address.
$ git config --global user.email <you>@spotify.com
$ git config --global user.name "Yourfirstname Yourlastname"
If you want to see what branch you’re on and its status, set up git bash-completion. Open the terminal and install it with:

$ brew install git bash-completion
Create a .bash_profile in your /Users/<your-username> folder containing:

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose # or auto to omit counts
export PS1='\h:\w$(__git_ps1 " (%s)")\$ '
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
Extra reading for the curious

Note
You make the changes take effect by restarting the shell or sourcing the .bash_profile., source ~/.bash_profile.

Java¶
Java is needed to develop data pipelines as well as running many of the command line tools for interacting with our data platform systems. Note that you need to install two different versions of the Java JDK, 8 and 11.

Download and install the latest versions of both Java SE JDK 8 and Java SE JDK 11.

Tip
You might need to create an Oracle account to perform the download. If you still experience problems, try using the Safari browser (if you are using Mac).

If you are using macOS, configure JAVA_HOME by adding the below line to your ~/.bashrc (or ~/.zshrc, etc) using a text editor and restart your terminal.

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
After installing the JDK, determine its version number via your Terminal:

$ java -version
java version "1.8.xxx"
Java(TM) SE Runtime Environment (build 1.8.xxx)
Java HotSpot(TM) 64-Bit Server VM (build xxx, mixed mode)
Important!

Make sure that you have followed the above instructions to configure Java 8 as the default Java version as higher versions are not supported by Scio and Dataflow.

Scala and SBT¶
Data pipelines are built with Scio, a Scala framework for running (big) data processing jobs. So to be able to write a data pipeline (which will be discussed in the next Golden Path tutorial), you need to install Scala and SBT (Simple Build Tool). SBT is the de facto build tool for Scala, equivalent to Maven for Java, Leiningen for Clojure, or Gradle for Groovy.

Install on Mac OS X using homebrew:

$ brew install scala sbt
Notes
On Linux:
As many Linux distributions often run old versions of Scala or SBT, download the latest binary for Scala and SBT. Unzip and symlink everything in bin to /usr/local/bin or somewhere in your $PATH.

On Debian/Ubuntu:
Install latest .deb from http://www.scala-lang.org/files/archive/ and follow http://www.scala-sbt.org/0.13/docs/Installing-sbt-on-Linux.html for SBT.

On Windows:
Install latest msi-packages from http://www.scala-lang.org/files/archive/ and https://www.scala-sbt.org/download.html - accepting all defaults. Set PATH to point to the scala/bin directory.

Start an interactive Scala shell with:

$ scala
The response is supposed to be:

Welcome to Scala version x.xx.x (Java HotSpot(TM) 64-Bit Server VM, Java x.x.x_xx).
Type in expressions to have them evaluated. Or try :help.

scala>
Exit with Ctrl+D.

Many Scala projects use SBT as the build system, and the project root directory of most Scala projects contains a build.sbt file that is the main build configuration file.

We use Artifactory at Spotify for sharing JVM libraries, and you need to set it up for SBT.

Run SBT:

$ sbt
Exit with Ctrl-D. Then, insert the following lines in ~/.sbt/1.0/global.sbt (create the file, if it is not present):
resolvers ++= Seq(
"Artifactory" at "https://artifactory.spotify.net/artifactory/repo",
"Local Maven Repository" at "file://" + Path.userHome.absolutePath + "/.m2/repository"
)
Maven¶
Maven is a tool for building and managing Java dependencies. It isn’t needed if you use SBT.

Install Maven:
$ brew install maven
Configure Maven to access our internal JAR-registry Artifactory.

Python¶
Python is not strictly required for most use cases outside Luigi definitions. But if you wish to ensure that your development environment and IDE find the used libraries, you benefit from having the basic Python tools in place.

Install on Mac OS X; install the latest available version of Python using brew:

$ brew install python@2
If you are told to run brew link python and you get permission errors, see this github thread.

Install on Linux; enter the following command:

apt-get install python
Set up the Spotify internal PyPi repository. Add the following to file ~/.pip/pip.conf

Create the directory (using mkdir -p) and config file, if needed.

[global]
extra-index-url = https://artifactory.spotify.net/artifactory/api/pypi/pypi/simple/
Tip

Check if pip is running on your terminal. If not, you might need to relink Python in order to have pip running after the brew install:

brew unlink python@2 && brew link python@2

If you experience problems, run brew doctor.

IntelliJ IDE¶
IntelliJ is the most common IDE at Spotify.

Install IntelliJ from here.
Note
We have a company-wide license for IntelliJ Ultimate and we recommend you use that one since some plugins that you’ll use for this Golden Path is only available in the Ultimate edition. Use the following license server: http://jblicense.spotify.net:8080 (it is autodetected by IntelliJ). If you’ve got an old version of IntelliJ, you may need to update it.

Configure IntelliJ to use the JDK you previously installed as follows:

Start IntelliJ.
When the Welcome screen appears, click Configure > Project Defaults > Project Structure.
Under Platform Settings, select SDKs.
Click the + button and select +JDK. Browse to and select the folder where the JDK was installed. Its name might be prefilled.

Example:
/Library/Java/JavaVirtualMachines/jdk1.8.0_<version>.jdk/Contents/Home
Click Apply but don’t close the Default Project Structure window yet.

Go to the Project SDK pulldown menu, select the correct JDK (1.8) and click OK.
IntelliJ Scala and SBT Plugins¶
When you work with Scala and SBT within IntelliJ, you need the official Scala and SBT plugins. Install them in the following way:

Note

If you work with IntelliJ version 2016.1 or later, you only need to install the Scala plugin, which includes the SBT plugin.

If you don’t have IntelliJ open from the previous steps, start IntelliJ.
IntelliJ opens with the Welcome to IntelliJ IDEA window.
Select Configure > Plugins > Install JetBrains Plugin... > Scala.

Install Scala.
If required to complete the installation of the plugins, restart IntelliJ.

IntelliJ Scio IDEA plugin¶
Start IntelliJ.

IntelliJ opens with the Welcome to IntelliJ IDEA window.
Select Configure > Preferences > Plugins > Browse repositories...

Enter Scio IDEA in the search field.
Click Install in the Scio IDEA installation window.

Install Scio IDEA
Click Close.
Complete the installation of the plugins by restarting IntelliJ.

IntelliJ Python plugin¶
On the Welcome to IntelliJ IDEA window, select Marketplace > Python > Python plugin by Jetbrains.

Enter Python in the search field. Select Python and click Install.

Click Install in the Python installation window.

Restart IntelliJ to complete the installation.

IntelliJ Java Code Style¶
Our code style is based on the Google Java Style Guide. More information on code style are available on this Confluence page.

Open your Terminal and download spotify-checkstyle-idea.xml from GHE:

$ curl -O https://raw.githubusercontent.com/spotify/spotify-checkstyle-config/master/src/main/idea/spotify-checkstyle-idea.xml
Select Configure > Preferences > Editor > Code Style in the IntelliJ Welcome screen.

Note
If you are working with IntelliJ on Linux or Windows, select:
Configure > Settings > Editor > Code Style
Click the settings icon at the top of the window and select Import Scheme > IntelliJ IDEA code style XML.

Settings dropdown

Note
If you are working with IntelliJ 2016 or earlier, select Manage > Import > IntelliJ IDEA code style XML and click OK.

Find the XML file you downloaded, click OK twice, then Close.

On the Code Style preferences screen, set the Scheme to "Spotify".

Make sure that Hard wrap at X columns is set to 100.

Click Apply, then OK.

IntelliJ Scala Code Style¶
We use this Scala codestyle in IntelliJ IDE.

Note
Scio template (backstage/cookie) is supplied with Scalastyle preconfigured, so if you are following the complete golden path, you don’t need to configure/do anything at this moment.

Brew Tap¶
Note

This step is only required if you use macOS. Your SSH authentication needs to be working to complete this step.

The Spotify brew tap is needed for some Spotify-specific tools. Install it from your Terminal window with:

$ brew tap spotify/sptaps git@ghe.spotify.net:shared/homebrew-spotify.git
$ brew update
Tip
For troubleshooting, see the FAQ in the README file.

Docker¶
Docker is a software container platform that we use to test, run, build, package and deploy our data pipelines.

Install Docker on Mac:

Install this package.

Install Docker on Ubuntu Linux:

Follow these instructions and make sure that you complete the sections Post-installation steps for Linux and Manage Docker as a non-root user.

To check whether your Docker installation was successful, run this command in your terminal:


$ docker run ubuntu echo hello world
If the response is hello world, everything is okay.

Styx Client¶
Styx is a service that is used to trigger periodic invocations of Docker containers. Styx is developed at Spotify where it is being used to run many production workflows.

We recommend that you install the Styx client (styx-cli) to simplify communication with Styx. Install it on Mac OS X with this command:

$ brew update && brew install styx-cli
Notes

If the install does not work, try:
$ ssh-add -K <key>
For a more permanent fix, see here.

If you get an error saying that you have two taps matching, you can disable one with:
$ brew untap spotify/internal
If you get other issues, check this FAQ.

Install it on Linux with this command:
$ sudo apt-get install styx-cli
Install it on Debian:
$ sudo apt-get install styx-cli
If you get:

$ E: Unable to locate package styx-cli
Run:
$ sudo vim /etc/apt/sources.list.d/spotify-private-stable.list
And ensure that the content of the file is:

# spotify-private-stable
deb http://debmirror:9444/trusty/ stable main non-free
deb-src http://debmirror:9444/trusty/ stable main non-free
To get an apt key for the repository, run:

$ curl -O https://repository.spotify.net/direct/trusty/pool/stable/non-free/apt-keys/spotify-apt-keys_2.0-1~0.0.0.72.efe7ce7.36_all.deb && sudo dpkg -i spotify-apt-keys_2.0-1~0.0.0.72.efe7ce7.36_all.deb
And then run:

$ sudo apt-get update && sudo apt-get install styx-cli
Help for the Styx client is obtained with this command:

$ styx -h

Hades client¶
Hades is a service handling metadata about datasets on GCS. It is the source of truth if a data endpoint partition is delivered or not. It can also handle that the same data endpoint partition exists in several revisions.

We recommend that you install the Hades client (hades-cli) to simplify communication with Hades.

Install it on Mac OS X with this command:

$ brew update && brew install hades-cli
Notes
If the install does not work, try:
$ ssh-add -K <key>
For a more permanent fix, see here.
If you get an error saying that you have two taps matching, you can disable one with:
$ brew untap spotify/internal
If you get other issues, check this FAQ.

Install it on Linux with this command:
$ sudo apt-get install hades-cli
Install on Debian:
Note
If you have followed the steps on install styx-cli for Debian, this install command should work for you. If not, follow the steps above and come back here for install hades-cli.
$ sudo apt-get install hades-cli
Help for the Hades client can be obtained with this command:
$ hades -h
The Hades client does not work with Java 8. To run it with Java 11 add an alias to your .bash_profile:

alias hades="JAVA_HOME=$(/usr/libexec/java_home -v 11) hades"

Scio REPL¶
Scio REPL is an extension of Scala REPL (Read-Eval-Print Loop) with additional functionality to experiment with Scio. Install it with this command if you use macOS (otherwise please check the wiki):

$ brew tap spotify/public && brew install scio
Note

If you get an error that says Error: Formulae found in multiple taps, make sure to brew untap the one that’s not spotify/public and you may now safely re-run the command again.

Scio-users¶
Join the Scio-users group to get access to the GCP project called scio-playground, which will be used later in this tutorial.

Google Cloud Console¶
Google Cloud Console is a web interface that we use for Google products.

Open the menu by clicking on the three bars (or "hamburger menu") in the top left corner of the banner bar.

At the top of your screen, left of the search bar, you see which project you are currently in. Most squads have their own project (or even one project per product that they own). Check which projects you have access to.

You will be using the project called scio-playground so make sure that you have access to that by now. If you’ve joined the correct LDAP groups, you shouldn’t run into problems with this.

Google Cloud SDK¶
In addition to the Console web interface described above, you can also use the command line tool gcloud. Once you get to know it, it is a faster way to execute basic tasks. To install gcloud, you need to install the Google Cloud SDK.

Install it with:
$ brew cask install google-cloud-sdk
If you are using a non-Mac environment we recommend installing gcloud using its interactive installer options outlined in these installation instructions.

Note
You will need to authenticate yourself before you can use the gcloud tool.

Run these commands to authenticate yourself:

$ gcloud auth login
$ gcloud auth application-default login
A web page is displayed where you can login to your Spotify Google account, which will be used as your identity.

Run this command to verify you're authenticated (it should show your @spotify account):
$ gcloud auth list
Note

It is recommended that you do this even when you're not planning to use the gcloud tool. If you want to deploy things to the Google cloud (even one-off tests), your deployment script often uses the authentication provided by this gcloud command.

Follow the instruction to login (if not yet), then set default project to scio-playground, and feel free to skip configuring Google Compute Engine.

Appendix A: Troubleshooting¶
For general assistance in setting up your laptop and getting access to our networks, talk to IT Services (helpdesk | email).

Troubleshooting this tutorial¶
General support for this tutorial is offered on the #data-support channel in Slack and through the data tag on Stack Enterprise.