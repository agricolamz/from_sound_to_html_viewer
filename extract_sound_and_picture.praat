# This script is distributed under the GNU General Public License.
# George Moroz 17.02.2019

form Get spectrum and oscilogram from 
  comment Where should the script write a result sound files?
  text directory_sound /home/.../
  comment Where should the script write a result picture files?
  text directory_picture /home/.../
endform

n = numberOfSelected()
for j to n
	files[j] = selected(j)
endfor
object_name$ = selected$ ("Sound")
select TextGrid 'object_name$'
number_of_tiers = Get number of tiers
for tier_n to number_of_tiers
	for j to n
		plusObject: files[j]
	endfor
	@plot_and_extract: directory_sound$, directory_picture$, tier_n
endfor

procedure plot_and_extract directory_s$, directory_p$, tier_number
	n = numberOfSelected()
	for j to n
		files[j] = selected(j)
	endfor
	object_name$ = selected$ ("Sound")
	select TextGrid 'object_name$'
	number_of_intervals = Count intervals where: tier_number, "is not equal to", ""
	name_of_tier$ = Get tier name: tier_number
	for k to number_of_intervals
		labels$[k] = Get label of interval: 'tier_number', k*2
	endfor
	for j to n
		plusObject: files[j]
	endfor
	Extract non-empty intervals: tier_number, "no"
	for b to number_of_intervals
		extracted[b] = selected("Sound", b)
	endfor
	for id to number_of_intervals
        id$ = string$ (id)
		selectObject: extracted[id]
		Save as WAV file: directory_s$ + object_name$ + "_" + name_of_tier$ + "_" + labels$[id] + "_" + id$ + ".wav"
		To Spectrogram: 0.005, 5000, 0.002, 20, "Gaussian"
		Select outer viewport: 0, 10, 3, 10
		Paint: 0, 0, 0, 0, 100, "yes", 50, 6, 0, "yes"
		Remove
		selectObject: extracted[id]
		Select outer viewport: 0, 10, 0, 3.5
		Draw: 0, 0, 0, 0, "yes", "Curve"
		Select outer viewport: 0, 10, 0, 10
		Text top: "yes", object_name$ + " " + name_of_tier$ + " " + labels$[id]
		Save as 300-dpi PNG file: directory_p$ + object_name$ + "_" + name_of_tier$ + "_" + labels$[id]+ "_" + id$ + ".png"
		Erase all
		Remove
	endfor
endproc
