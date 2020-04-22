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
    var gitCommand = "git diff `git merge-base origin/master HEAD`..HEAD --numstat | egrep \"\.(swift|m|h)$\" | awk '{ sum += $1; } END { print sum; }' \"$@\"";
    var result = app.doShellScript("cd " + gitFolder + ";" + gitCommand);
    console.log(result)

    if (result.length == 0) {
        delay(5);
        continue;
    }

    var numChanges = result * 1;

    if (numChanges > MAX_CHANGES_NUM) {
        app.displayNotification("У тебя уже " + numChanges + " изменений!\nНе пора ли запилить ПУЛЛИК?🤔", {withTitle: "GIT ALARM!", soundName: "Basso"});
    }

    delay(60);
}

