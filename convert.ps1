$folder = "ex_RRFB_Beal_EB"
foreach ($file in get-ChildItem $folder\*.avi) {
	echo $file.name
	$name = $file.name
	ffmpeg.exe -i $folder\$name -q:a 0 -q:v 0 $folder\converted\$name
}
$folder = "ex_RRFB_CG_EB"
foreach ($file in get-ChildItem $folder\*.avi) {
	echo $file.name
	$name = $file.name
	ffmpeg.exe -i $folder\$name -q:a 0 -q:v 0 $folder\converted\$name
}

$folder = "ex_RRFB_TN_EB"
foreach ($file in get-ChildItem $folder\*.avi) {
	echo $file.name
	$name = $file.name
	ffmpeg.exe -i $folder\$name -q:a 0 -q:v 0 $folder\converted\$name
}