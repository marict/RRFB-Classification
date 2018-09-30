Write-Host "***** Begin *****"
function write-Labels {
	param( [String]$fname )
	$def_path = "C:\Users\curryp\Desktop\Manual_RRFB\manual_RRFB_converted\"
	$file_path_string = "$($def_path)$($fname)"
	
	#Create CSV
	$csv_path = "$($file_path_string).csv"
	Add-Content -Path $csv_path -Value '"device","trip","starttime","endtime","RRFBlabel"'
	
	
	# Flashing
	$flash_path = "$($file_path_string)\Flashing"
	foreach($file in get-childitem (Get-Item $flash_path)) {
		$split = $file.FullName.Split("{_}")
		$device = $split[7]
		$trip = $split[8]
		$starttime = $split[9]
		$endtime =  $split[10].Split("{.}")[0]
		$line = "$($device), $($trip), $($starttime), $($endtime), 0"
		# Write-Host "	$($line)"
		# Write-Host "	-------"
		
		Add-Content -Path $csv_path -Value $line
	}

	# Not_Flashing (Indices need to be bumped up by 1)
	$flash_path = "$($file_path_string)\Not_Flashing"
	foreach($file in get-childitem (Get-Item $flash_path)) {
		$split = $file.FullName.Split("{_}")
		$device = $split[8]
		$trip = $split[9]
		$starttime = $split[10]
		$endtime =  $split[11].Split("{.}")[0]
		$line = "$($device), $($trip), $($starttime), $($endtime), 1"
		# Write-Host "	$($line)"
		# Write-Host "	-------"
		
		Add-Content -Path $csv_path -Value $line
	}
	
	# Unknown
	$flash_path = "$($file_path_string)\Unknown"
	foreach($file in get-childitem (Get-Item $flash_path)) {
		$split = $file.FullName.Split("{_}")
		$device = $split[7]
		$trip = $split[8]
		$starttime = $split[9]
		$endtime =  $split[10].Split("{.}")[0]
		$line = "$($device), $($trip), $($starttime), $($endtime), 2"
		# Write-Host "	$($line)"
		# Write-Host "	-------"
		
		Add-Content -Path $csv_path -Value $line
	}
	Write-Host "	Wrote: $($csv_path)" 
}

$content_path1 = "ex_RRFB_Beal_EB"
$content_path2 = "ex_RRFB_CG_EB"
write-Labels $content_path1
write-Labels $content_path2

Write-Host "***** END *****"

# EXTRA STUFF -----------------------------

# $files1 = get-childitem $content_path
# foreach($file in $files1) {
	# Write-Host $file.FullName
	# $files2 = get-childitem $file.FullName
	# foreach($file in $files2) {
		# $split = $file.FullName.Split("{_}")
		# $device = $split[4]
		# $trip = $split[5]
		# $starttime = $split[6]
		# $endtime =  $split[7].Split("{.}")[0]
		# Write-Host $device , $trip, $starttime, $endtime
		# Write-Host "-------"
	# }
# }

# $csv_path = "C:\Users\curryp\Desktop\Manual_RRFB\manual_RRFB_converted\test.csv"
# Add-Content -Path $csv_path -Value '"device","trip","starttime","endtime"'

  
# $employees = @(

# '"Adam","Bertram","abertram"'

# '"Joe","Jones","jjones"'

# '"Mary","Baker","mbaker"'

# )

# $employees | foreach { Add-Content -Path $csv_path -Value $_ }

  