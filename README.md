# rot.sh
<p>ROT13 is a simple letter subsititution cipher. This script is a basic utility written in BASH that allows the user to ROT13 strings - from cli parameters, an input file, STDIN, and from a prompt.</p>

## Why was this created?
<p>This was intended to be a teaching tool. I had several goals:</p>
1. to reinforce the idea that shell scripts should be unit tested.
2. to suggest simple shell scripting guidelines for beginners.
3. to introduce simple cryptography concepts to/for beginners.

## What could this be used for?
- For learning or teaching unit testing for BASH.
- For learning or teaching defensive BASH scripting skills.
- To execute the ROT13 substitution cipher.

## Don't use this to keep secrets!
<p>Seriously, just don't. ROT13 is the cryptographic equivalent to throwing a balled up note to your friend across the room when the teacher isn't looking. There are times when subsititution ciphers are appropriate (example: games), but if you need to properly keep something secret, this is not the tool for you. I suggest looking into something like GPG.</p>

## How do you use this?
### Minimum Requirements:
- BASH (Linux, MacOS, Cygwin, WSL1/2, etc)
- [shUnit2](https://github.com/kward/shunit2) (if you're interested in running the tests)
- Familiarity with a command line

### Parameter breakdown
**-i --inline**: <p>This option is for encrypting text as a parameter. Immediately after the -i or --inline needs to be your quoted text. Prints to STDOUT.</p>
**-f --file**: <p>For encrypting the entire contents of a file. Immediately after -f or --file you need to specify a file name. Prints to STDOUT.</p>
**-h --help**: <p>Use this option to print the help message. </p>
**-t --tests**: <p>This options is for running unit tests. Immediately after -t or --tests you need to specify the path to shunit2. For more information, start here: [shUnit2](https://github.com/kward/shunit2) </p>
**NO OPTIONS**: <p>If you run this script without any options, it prompts you to enter text unless text is supplied via STDIN.</p>

### Examples
**Encrypting from STDIN:**  
`$ echo 'dogs are good' | ./rot.sh`

**Encrypting text as a parameter:**  
`$ ./rot.sh -i "we don't deserve dogs"`

**Encrypting from a prompt:**  
`$ ./rot.sh`  
`type your input on the next line, then hit enter`

**Asking for help:**  
`$ ./rot.sh -h`

**Encrypting a file:**  
`$ ./rot.sh -f filename`

**Running the unit tests:**  
`$ ./rot -t /path/to/shunit2`

### Installation
<p> If you are interested in having rot13 available as an installed utility, these instructions will help with that. Because this is a teaching tool, we'll do the install manually. :sunglasses:</p>
#### Method 1, adding an alias (PREFERRED)
<p>While this isn't technically an *installation*, it achieves similar functionality without some of the sacrifices of Method 2.</p>
- Start by cloning this git repository someplace memorable.
- You can do future upgrades by pulling the latest version of this git repository.
    $ alias rot13='/path/to/rot13/rot.sh'
    $ rot13 --help # to test it was installed correctly
#### Method 2, adding it to your path
<p> There are a few considerations to keep in mind, but I won't spend too much time on them. There are details in the further reading section if you're interested:</p>
- It's not fun to have an installed utility that has a file extension. I have chosen to rename it to "rot13", because it is easy to remember and is less likely to collide with other installed tools.
- There are many correct ways to do this, this is just one example.
- You can follow these directions again (overwriting the existing) if you need to do an upgrade in the future.
- Download the release files, or clone the repo to somewhere on the filesystem to begin:  
    $ cd /path/to/rot13
    $ echo $PATH
    Look through the output, and pick a directory that seems appropriate. Something in ~/, or /home/yourusername/ is potentially the best choice. I will refer to the folder you just chose as /your/destination/path
    $ cp rot.sh rot13
    $ mv rot13 /your/destination/path
    $ rot13 --help # to test it was installed correctly

## Further reading
- Want to know more about ROT13? [ROT13 Wikipedia](https://en.wikipedia.org/wiki/ROT13)
- Want to know more about the Caesar cipher? [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
- [Unoffical BASH strict mode](http//redsymbol.net/articles/unofficial-bash-strict-mode/)
- I think strictly enforcing all of this would be overwhelming for many newcomers but I nonetheless drew much inspiration from the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.htmlhttps://google.github.io/styleguide/shellguide.html)

## Feedback
<p>Let me know what you think! Feel free to create an issue, or contact me directly.</p>
