function Leap {
	param( [int]$year)
	# This could be solved using the native system.datetime object
	# but that isn't in the spirit of exercism. 
	#[system.datetime]::isleapyear($year)

	# Instead solve using math
	if ( $year % 4 -eq 0 -and $year % 100 -ne 0 -or $year % 400 -eq 0) {
		return "True"
	}
	else {
		return "False"
	}
}
