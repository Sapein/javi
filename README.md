# javi - a basic Java Plugin for vim.

   Javi is a basic Java Plugin for Vim.

### Features
- All Features are customizable
- Sets up the compiler for java programs so that `:make` uses javac not make.
- Auto-Defines class-path/source-path (if not set by the environment) for javac to use, based on the open buffer.

#### Enabling/Disabling Features
You may enable/disable features for javi by setting the appropriate configuration variable in your vimrc:
- compiler-setup: `g:javi_compiler_java=(0|1) "0 for enable, 1 for disable`
- classpath-setup: `g:javi_classpath=(0|1) "0 for enable, 1 for disable`
- sourcepath-setup: `g:javi_sourcepath=(0|1) " 0 for enable, 1 for disable`

## Licensing and Copyright
This project is available under the MIT (Expat) License, the terms can be found in LICENSE

All Copyright belongs to the respective authors.

## QnA  
#### Why does this exist?  
  Because I had several things I wanted, and decided to shove them into a plugin, so I can easily manage it.

#### Will this be updated?
  It will be updated as I need it, although I will accept patches to fix things for others.
