# This script is distributed under the GNU General Public License.
# George Moroz 26.03.2019
# The last vertion of this script is here: https://raw.githubusercontent.com/agricolamz/from_sound_to_html_viewer/master/extract_sound_and_picture_one_tier.praat

form Get spectrum and oscilogram from 
  comment Where should the script write a result sound files?
  comment don't forget the final slash; on Windows change your backslashes to slashes
  text directory_audio /home/agricolamz/work/materials/2019_Soqotri/sound/
  comment Where should the script write a result picture files?
  comment don't forget the final slash; on Windows change your backslashes to slashes
  text directory_picture /home/agricolamz/work/materials/2019_Soqotri/pictures/
  comment Which tier is the basis for picture frame?
  integer picturetier 4
  comment Which tier is a word tier?
  integer wordtier 3
  comment Which tier is a utterance tier?
  integer utterancetier 4
  comment Which tier is a type tier?
  integer typetier 5
  comment What is the maximum formant value for your pictures (Hz)?
  positive max_frequency 5000
  comment What is the dynamic range value for your pictures (Db)?
  positive dynamic_range 50
endform

n = numberOfSelected("Sound")
for j to n
	sound[j] = selected("Sound", j)
endfor
for k to n
	selectObject: sound[k]
	object_name$ = selected$ ("Sound")
	select TextGrid 'object_name$'
	number_of_intervals = Get number of intervals: 'picturetier'
	for b to number_of_intervals
		label$ = Get label of interval: 'picturetier', b
		if label$ != ""
		        b$ = string$ (b)
			start[b] = Get start time of interval: 'picturetier', b
			end[b] = Get end point: 'picturetier', b
			word_int = Get interval at time: wordtier, end[b]
			word$[b] = Get label of interval... wordtier word_int
			utterance_int = Get interval at time: utterancetier, end[b]
			utterance$[b] = Get label of interval... utterancetier utterance_int
			Extract part: start[b], end[b], "yes"
			select Sound 'object_name$'
			Extract part: start[b], end[b], "rectangular", 1, "yes"
			Save as WAV file: directory_audio$+object_name$+"_" + word$[b] + "_" + utterance$[b] + "_" + label$ + "_" + b$ + ".wav"
			Select outer viewport: 0, 10, 0, 6
			To Spectrogram: 0.005, max_frequency, 0.002, 20, "Gaussian"
			Paint: 0, 0, 0, 0, 100, "yes", dynamic_range, 6.5, 0, "no"
			Marks left: 6, "yes", "yes", "yes"
			Remove
			selectObject: "TextGrid " + object_name$ + "_part"
			plusObject: "Sound " + object_name$ + "_part"
			Select outer viewport: 0, 10, 4, 10
			Draw: 0, 0, "yes", "yes", "no"
			Marks bottom: 6, "yes", "yes", "yes"
			Select outer viewport: 0, 10, 0, 10
			Text top: "yes", object_name$ + "   " + label$  + "   " +b$
			Save as 300-dpi PNG file: directory_picture$+object_name$+"_"+ word$[b] + "_" + utterance$[b] + "_" + label$ + "_" + b$ + ".png"
			Erase all
			Remove
			select TextGrid 'object_name$'
		endif
	endfor
endfor
