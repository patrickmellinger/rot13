# rot.sh
ROT13 is a simple letter subsititution cipher. This script is a basic utility written in BASH that allows the user to ROT13 strings - from cli parameters, an input file, STDIN, and from a prompt.

## Why did you create this?
This was intended to be a teaching tool. I had several goals: 
1. to reinforce the idea that shell scripts should be unit tested.
2. to suggest simple shell scripting guidelines for beginners.
3. to introduce simple cryptography concepts to/for beginners.

## How do you use this?
### Minimum Requirements:
- BASH (Linux, MacOS, Cygwin, WSL1/2, etc)
- [shUnit2](https://github.com/kward/shunit2) (for testing)
- Familiarity with a command line

### Parameter breakdown
```
-i --inline     This option is for encrypting text as a parameter. Immediately after the -i or --inline needs to be your quoted text. Prints to STDOUT.
-f --file       For encrypting the entire contents of a file. Immediately after -f or --file you need to specify a file name. Prints to STDOUT.
-h --help       Use this option to print this help message. 
-t --tests      This options is for running unit tests. Immediately after -t or --tests you need to specify the path to shunit2. For more information, start here: [shUnit2](https://github.com/kward/shunit2) 
NO OPTIONS      If you run this script without any options, it prompts you to enter text unless text is supplied via STDIN.
```

### Examples
Encrypting from STDIN:  
`$ echo 'dogs are good' | ./rot.sh`

Encrypting text as a parameter:  
`$ ./rot.sh -i "we don't deserve dogs"`

Encrypting from a prompt:  
`$ ./rot.sh`  
`type your input on the next line, then hit enter`

Asking for help:  
`$ ./rot.sh -h`

Encrypting a file:  
`$ ./rot.sh -f filename`

Running the unit tests:  
`$ ./rot -t /path/to/shunit2`

## Further reading
- Want to know more about ROT13? [ROT13 Wikipedia](https://en.wikipedia.org/wiki/ROT13)
- Want to know more about the Caesar cipher? [Caesar Cipher](https://en.wikipedia.org/wiki/Caesar_cipher)
- [Unoffical BASH strict mode](http//redsymbol.net/articles/unofficial-bash-strict-mode/)
- I think strictly enforcing all of this would be overwhelming for many newcomers but I nonetheless drew much inspiration from the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.htmlhttps://google.github.io/styleguide/shellguide.html)

## Feedback
Let me know what you think! Feel free to create an issue, or contact me directly. 
