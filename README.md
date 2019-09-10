# d-progress-bar
Small code i use for creating nice progress bars in bash-like environments

# Usage
To use this you need to copy `progress.d` into your source folder and import it with `import progress`. You may safely rename the module if you want, because it doesn't affect anything inside.
The module relies on D standard library and does not need anything else to work.
After adding `progress.d` to your sources just compile them as usual.

# Example
The example program shows you how the progress bar works. You can either use DMD to compile it: `dmd -O example.d progress.d`

Or use rdmd: `rdmd example.d progress.d`

Or use the bash script: `./run-sample.sh`

Don't forget that you first give the compiler the module which contains an entry point and then all other files.
