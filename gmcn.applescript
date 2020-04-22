var DefaultSettings = {
    gitFolder: "",
    maxChanges: 1000,
    checkInterval: 60*10,
}

var app = Application.currentApplication()
app.includeStandardAdditions = true

var seApp = Application("System Events");

var Settings = DefaultSettings;

var settingsPlistPath = Path(app.doShellScript("cd ~; pwd") + "/gmcn.plist");

var settingsKeys = {
    gitFolder: "git_folder",
    maxChanges: "max_changes",
    checkInterval: "check_interval",
};

if (!seApp.exists(settingsPlistPath)) {
    var gitFolder = app.chooseFolder({
        withPrompt: "Please select a git folder:"
    });

    console.log(gitFolder);

    var item1 = {}
    item1[settingsKeys.gitFolder] = gitFolder.toString();
    item1[settingsKeys.maxChanges] = Settings.maxChanges;
    item1[settingsKeys.checkInterval] = Settings.checkInterval;

    var plist = $.NSDictionary.dictionaryWithDictionary(item1);
    plist.writeToFileAtomically(settingsPlistPath.toString(), true);
}

var content = $.NSDictionary.dictionaryWithContentsOfFile(settingsPlistPath.toString());
var plistDict = ObjC.deepUnwrap(content);
Settings.gitFolder = plistDict[settingsKeys.gitFolder];
Settings.maxChanges = plistDict[settingsKeys.maxChanges];
Settings.checkInterval = plistDict[settingsKeys.checkInterval];

while (true) {
    var gitCommand = "git diff `git merge-base origin/master HEAD`..HEAD --numstat | egrep \"\.(swift|m|h)$\" | awk '{ sum += $1; } END { print sum; }' \"$@\"";
    var fullCommand = "cd " + Settings.gitFolder + ";" + gitCommand;
    var result = app.doShellScript(fullCommand);
    console.log(fullCommand + ": " + result);

    var numChanges = result * 1;

    if (numChanges > Settings.maxChanges) {
        app.displayNotification("У тебя уже " + numChanges + " изменений!\nНе пора ли запилить ПУЛЛИК?🤔", {withTitle: "GIT ALARM!", soundName: "Basso"});
    }

    delay(Settings.checkInterval);
}