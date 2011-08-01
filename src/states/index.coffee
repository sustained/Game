define [
	'app/states/load'
	'app/states/main'
	'app/states/title'
], (Load, Main, Title) ->
	return @States = {Load, Main, Title}
