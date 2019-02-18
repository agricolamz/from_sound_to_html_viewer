This repository is an example of how to create .html Viewer from annotated file.

* annotate your files (sound file and a TextGrid that have the same name) and upload it to Praat
* create some folders where you want to store pictures and sounds from your annotation
* select both the Sound and the TextGrid files 
* run [praat script](https://raw.githubusercontent.com/agricolamz/from_sound_to_html_viewer/master/extract_sound_and_picture.praat) that will extract pictures and sound from all tiers in your TextGrid
* change 17th and 19th line of [the script](https://raw.githubusercontent.com/agricolamz/from_sound_to_html_viewer/master/create_html.Rmd) with correct path and run the script
* open obtained .html file

The example files could be found in a repository folders `source`,  `sound` and `picture`. The obtained html example could be found [here](https://agricolamz.github.io/from_sound_to_html_viewer/create_html.html).
