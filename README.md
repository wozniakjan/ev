# ev

Bash script that makes having multiple Erlang/OTP versions convenient. 
Install, build, and use with autocomplete.

###How does it work
The `ev` will clone the official Erlang/OTP git repository and build any revision
you would desire on your machine. Once you build a revision, `ev` keeps them for
later reuse.

Initialize `ev init` in any of your projects and set the Erlang version you'd like 
to be used there from the ones you have already build. The `ev` keeps track of the 
versions set per folder, quite like `git` does for its repositories, so you can use 
different versions for different projects without the need to call `ev` to change 
Erlang each time you want to build something.

The `ev` prepends the `PATH` variable any time a folder maintained by ev is entered
and restores back when you leave the folder.

<img src="https://raw.githubusercontent.com/wozniakjan/ev/master/img/example.gif" height="150" width="600">


###How to get it
You will need a bash and common dependencies for building Erlang from the source.

Clone the repository
    
    git clone https://github.com/wozniakjan/ev.git

Run the install script and press `enter` couple of times

    cd ev
    ./install

It will ask you where it should install itself and a few of other things, then 
it will clone the Erlang/OTP repository. If you are unsure what is the script asking 
you, your best bet is to keep the default value.

<img src="https://raw.githubusercontent.com/wozniakjan/ev/master/img/install.gif" height="150" width="600">

Once it's installed, you may want to tinker a bit with your `.bashrc`, then close 
your current shell session and open a new one.


###How to use it
After you installed `ev`, you will want to build some Erlang version
    
    ev repo tag OTP-17.3.4      # checkout Erlang tag OTP-17.3.4
    ev repo deploy 17.3.4       # configure, build and deploy as 17.3.4

Go to a directory with any of your projects and run

    ev init
    ev set 17.3.4

This project will be using Erlang/OTP revision OTP-17.3.4 every time you build it
or use Erlang from this directory not affecting rest of your system. Well, until 
you change it again.
