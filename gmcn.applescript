var DefaultSettings = {
    gitFolder: "",
    maxChanges: 1000,
    changesCheckInterval: 60
}

var countSubcomand = "egrep \"\.(swift|m|h)$\" | awk '{ sum += $1; } END { print sum; }' \"$@\"";
var gitCommittedDiffCommand = "git diff `git merge-base origin/master HEAD`..HEAD --numstat";
var gitNonIndexDiffCommand = "git diff --numstat";
var gitIndexDiffCommand = "git diff --staged --numstat";

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
    var gitFolder;
    var checkResult;
    var chooseFolder = function() {
        gitFolder = app.chooseFolder({
            withPrompt: "Please select a git folder:"
        });
        checkResult = app.doShellScript("cd " + gitFolder + "; git status &> /dev/null && echo 1; (exit 0)");
    }

    chooseFolder();

    while (checkResult != "1") {
        app.displayAlert("Selected folder isn't git repository!");
        chooseFolder();
    }

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

var lastChangesNumber = 0;

while (true) {
    console.log("check... lastChangesNumber = " + lastChangesNumber);
    var numChanges = getCommittedDiffCount() + getNonIndexDiffCount() + getIndexDiffCount();
    if (numChanges > Settings.maxChanges && numChanges > lastChangesNumber) {
        showNotification();
    }

    lastChangesNumber = numChanges;

    delay(Settings.changesCheckInterval);
}

function showNotification() {
    app.displayNotification("У тебя уже " + numChanges + " изменений!\nНе пора ли запилить ПУЛЛИК?🤔", {withTitle: "GIT ALARM!", soundName: "Basso"});
}

function execCommandInDir(dir, command) {
    var fullCommand = "cd " + Settings.gitFolder + ";" + command;
    console.log(fullCommand);
    var result = app.doShellScript(fullCommand);
    console.log(result);

    return result;
}

function getCommittedDiffCount(dir) {
    return execCommandInDir(dir, gitCommittedDiffCommand + " | " + countSubcomand) * 1;
}

function getNonIndexDiffCount(dir) {
    return execCommandInDir(dir, gitNonIndexDiffCommand + " | " + countSubcomand) * 1;   
}

function getIndexDiffCount(dir) {
    return execCommandInDir(dir, gitIndexDiffCommand + " | " + countSubcomand) * 1;
}