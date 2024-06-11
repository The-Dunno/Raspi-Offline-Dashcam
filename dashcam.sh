#    This is a bash script to record dashcam footage on a raspberry pi.
#    Copyright (C) 2024  Warrick Cleet
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see https://www.gnu.org/licenses/gpl-3.0.html.
#    Contact me at groundsweepr@proton.me
#!/bin/bash
touch ~/log4dashcam.txt
echo 'Started at '$(date)'.' >> /dashcam/log4dashcam.txt
for ((i = 0; i < 100; i++)); do
	when=$(date)
	when=${when// /_}
	echo 'Started recording at '$when'.' >> /dashcam/log4dashcam.txt
	rpicam-vid -t 10m -o /dashcam/vids/$when.h264
        space=$(df -h | grep "/dev/mapper/flashpo1nt--vg-root" | grep M | awk -F "{print $1, $2, $3}")
	if[space -lt 250]; then
		rm -- "$(ls -rt /dashcam/vids | head -n 1)"
	fi
done
