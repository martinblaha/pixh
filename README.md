## About

[![Join the chat at https://gitter.im/martinblaha/pixh](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/martinblaha/pixh?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A little photo management helper in Ruby.

For now, it just takes a directory with your images and sorts out contained photos according to the date when they got shot. If a file doesn't contain EXIF or contains wrong EXIF information, it's being ignored, new log entry created (pixd.log in the source directory).

### Usage

I wrote this little helper to use it my photo workflow. This consits today of:

a) automatic sync of pictures from my Smartphones and Tablets (by using BitTorrent Sync on my iOS and Android devices) into a local folder (on my network HDD connected to Raspberry PI)

b) Sorting out picutres from a) into a time line folder structure (/year/month/day). While sorting out the program also renames the files so they are sortable by time taken

#### Supported file extensions

* Images jpeg,jpg,JPG,JPEG,png,PNG,raw,RAW,TIFF,tiff,TIF,tif,BMP,bmp,DIVX,divx
* Movies mov,MOV,mpeg,MPEG,mpg,MPG,mp4,MP4,avi,AVI,m4v,M4V

´´´pixd SOURCE DESTINATION´´´

#### Example

pixd . /mnt/myhdd/martin/pictures/library
=> Fotos from current directory will be sorted out to your external hardrive.

## TODO

* provide option to remove files from SOURCE (when successfuly copied)
* provide option to put problematic files to "Karantene" folder
