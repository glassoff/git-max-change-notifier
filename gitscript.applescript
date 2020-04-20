var app = Application.currentApplication()
app.includeStandardAdditions = true
 
var gitFolder = app.chooseFolder({
    withPrompt: "Please select an git folder:"
})

while (true) {
	var result = app.doShellScript("cd " + gitFolder + "; git diff master --numstat");
	
	var lines = result.split("\r");
	
	var numChanges = 0;
	
	for (var i = 0; i < lines.length; i++) {
		var line = lines[i];
		var parts = line.split("	");
		
		var additionalsNum = parts[0];
		var deletionsNum = parts[1];
		
		var fileNumChanges = 0;
		
		if (additionalsNum != "-") {
			fileNumChanges += additionalsNum * 1;
		}
		
		if (deletionsNum != "-") {
			fileNumChanges += deletionsNum * 1;
		}
		
		numChanges += fileNumChanges;
	}
	
	app.displayNotification(numChanges);
	
	delay(5);
}