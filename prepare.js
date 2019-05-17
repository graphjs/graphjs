const fs = require('fs');

const  fileName =  './lib/tagsImports.js';

const modulesAvailable = [
		"activity",
		"authentication",
		"blog",
		"comments",
        "feed",
		"forum",
		"groups",
		"members",
		"messages",
		"notifications",
		"profile",
		"show",
		"star",
		"private",
		"stripe"
];

const import_tags={
	activity: [

	],
    authentication: [
    	"auth",
		"auth-state",
		"auth-login",
		"auth-register",
		"auth-reset"
	],
    blog: [
    	"blog",
		"blog-list",
		"blog-post"
	],
    comments: [
    	"comments"
	],
    feed: [
        "feed",
        "feed-activity",
        "feed-composer",
        "feed-display",
        "feed-item"
    ],
    forum: [
    	"forum",
		"forum-list",
		"forum-thread",
		"forum-composer"
	],
    groups: [
    	"group",
		"group-card",
		"group-creator",
		"group-header",
		"group-activity",
		"group-members",
		"group-settings",
		"group-list"
	],
    members: [

	],
    messages: [
    	"messages",
		"messages-composer"
	],
	notifications: [
		"notifications",
		"notifications-button",
		"notifications-list"
	],
    profile: [
		"profile",
		"profile-cards",
		"profile-header",
		"profile-activity",
		"profile-followers",
		"profile-following",
		"profile-groups",
		"profile-settings",
		"profile-list"
	],
    show: [],
    star: [
    	"star-button",
		"star-list"
	],
    private: [
		"private-content"
	],
    stripe: [],
};

if(process.env.modules && process.env.modules !== "all"){
    requiredModules = modulesAvailable.filter(value => -1 !== process.env.modules.split(',').indexOf(value))
} else {
    requiredModules = modulesAvailable;
}

let importOnly = `// These are dynamically imported .. Please check prepare.js in root folder\n`

requiredModules.forEach(
    item_group => {
        importOnly += `\n// ${item_group}\n`;
        import_tags[item_group].forEach(
            single_tag => importOnly += `import './tags/${single_tag}.tag';\n`
        );
    }
);


writeToFile(fileName,importOnly);
console.log(`Ready to build modules - ${requiredModules.join(", ")}\n\n`);

function checkForFile(fileName,callback) {
    fs.exists(fileName, function (exists) {
        if(exists) {
            callback();
        } else {
            fs.writeFile(fileName, {flag: 'wx'}, function (err, data) { 
                callback();
            })
        }
    });
}

function writeToFile(fileName,data) {
    checkForFile(fileName,function() {
           fs.writeFileSync(fileName, data);
    });
}