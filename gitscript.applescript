var MAX_CHANGES_NUM = 1000;
var WITH_DELETIONS = false;

var app = Application.currentApplication()
app.includeStandardAdditions = true

var seApp = Application("System Events");

var settingsPlistPath = Path(app.doShellScript("cd ~; pwd") + "/gitdir.plist");

var gitFolder;

if (seApp.exists(settingsPlistPath)) {
	var content = $.NSDictionary.dictionaryWithContentsOfFile(settingsPlistPath.toString());
	var plistDict = ObjC.deepUnwrap(content);
	gitFolder = Path(plistDict["gitdir"]);
} else {
	gitFolder = app.chooseFolder({
    	withPrompt: "Please select a git folder:"
	})
	
	var item1 = {"gitdir": gitFolder.toString()};
	var plist = $.NSDictionary.dictionaryWithDictionary(item1);
	plist.writeToFileAtomically(settingsPlistPath.toString(), true);
}

while (true) {
	var result = app.doShellScript("cd " + gitFolder + "; git diff --numstat origin/master...HEAD");

	if (result.length == 0) {
		delay(5);
		continue;
	}
	
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
		
		if (WITH_DELETIONS && deletionsNum != "-") {
			fileNumChanges += deletionsNum * 1;
		}
		
		numChanges += fileNumChanges;
	}
	
	if (numChanges > MAX_CHANGES_NUM) {
		app.displayNotification("У тебя уже " + numChanges + " изменений!\nНе пора ли запилить ПУЛЛИК?🤔", {withTitle: "GIT ALARM!", soundName: "Basso"});
	}
	
	delay(60);
}