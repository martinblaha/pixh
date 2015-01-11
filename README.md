## About

A little photo management helper in Ruby.

For now, it just takes a directory with your images and sorts out contained photos according to the date when they got shot. If a file doesn't contain EXIF or contains wrong EXIF information, it's being ignored, new log entry created (pixd.log in the source directory).

### Usage

pixd SOURCE DESTINATION

#### Example

pixd . /mnt/myhdd/martin/pictures/library
=> Fotos from current directory will be sorted out to your external hardrive.

## TODO

