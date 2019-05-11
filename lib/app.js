// Riot
import riot from 'riot';
import 'riot-hot-reload';

const options={
	modules: [
		"activity",
		"authentication",
		"blog",
		// "comments",
        // "feed",
		// "forum",
		// "groups",
		// "members",
		// "messages",
		// "notifications",
		// "profile",
		// "show",
		// "star",
		// "private",
		// "stripe"
	]
};

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
    show: [

	],
    star: [
    	"star-button",
		"star-list"
	],
    private: [
		"private-content"
	],
    stripe: [

	],
};

const import_scripts={
    activity: [
		"getActivityToken",
    ],
    authentication: [
        "getSession",
        "getUser",
        "login",
        "logout",
		"register",
		"reset",
		"verify",
        "showAlert",
        "showAuth",
        "showLogin",
        "showRegister",
        "showReset",
    ],
    blog: [
        "commentBlogPost",
		"editBlogPost",
		"editBlogComment",
		"getBlogComments",
		"getBlogPost",
		"getBlogPosts",
		"removeBlogPost",
		"removeBlogComment",
		"startBlogPost",
		"unpublishBlogPost",
        "showBlog",
        "showBlogComposer",
        "showBlogList",
        "showBlogPost",
    ],
    comments: [
        "addComment",
		"getComments",
		"removeComment",
        "showComments",
    ],
    feed: [
        "getStatusUpdates",
        "getStatusUpdate",
		"updateStatus",
		"removeStatusUpdate",
        "showFeedItem",
    ],
    forum: [
        "getThread",
		"getThreads",
		"removeReply",
		"replyThread",
		"startThread",
        "showForum",
        "showForumComposer",
        "showForumList",
        "showForumThread",
    ],
    groups: [
        "createGroup",
        "getGroup",
        "joinGroup",
        "leaveGroup",
        "listGroups",
        "listMembers",
        "setGroupCover",
        "setGroupDescription",
		"setGroupTitle",
        "showGroup",
        "showGroupCreator",
    ],
    members: [
		"follow",
		"getFollowers",
		"getFollowing",
		"getMembers",
		"unfollow",
    ],
    messages: [
        "countUnreadMessages",
        "getConversation",
		"getConversations",
		"getInbox",
		"getMessage",
		"getOutbox",
		"sendAnonymousMessage",
		"sendMessage",
        "showMessages",
        "showMessagesComposer",
    ],
    notifications: [
        "getNotifications",
        "showNotificationsList",
    ],
    profile: [
        "getProfile",
        "listMemberships",
        "setAvatar",
        "setBio",
        "setBirthday",
        "setEmail",
        "setPassword",
        "setProfile",
        "setUsername",
        "showProfile",
    ],
    show: [
		"showOverlay",
    ],
    star: [
        "star",
        "getStar",
		"getStars",
		"getUserStars",
		"removeStar",
    ],
    private: [
        "getPrivateContent",
		"removePrivateContent",
		"editPrivateContent",
		"addPrivateContent",
    ],
    stripe: [
		"createSubscription",
		"checkSubscription",
		"tokenLogin",
    ],
};

// General Tags
import './tags/input-file.tag';
import './tags/input-text.tag';
import './tags/feedback.tag';
// import './tags/list.tag';
import './tags/file-upload.tag';
import './tags/promo.tag';
import './tags/overlay.tag';
import './tags/autocomplete.tag';
import './tags/alert.tag';

// Styles
import './styles/common.less';
import 'filepond/dist/filepond.css';
import 'filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css';

// The only init-level script
import './scripts/tokenLogin.js';

// Color
import renderColor from './scripts/renderColor.js';

import NanoEvents from 'nanoevents';
import languageData, {availableLanguages } from './language';

// Render theme
const renderTheme = () => {
	const localFile = '../dist/graphjs-theme.less';
	const globalFile = 'https://graphjs.com/graphjs-theme.less';
	// Check if local file exists
	fetch(localFile).then((response) => {
		// Create stylesheet
		let stylesheet = document.createElement('link');
		stylesheet.id = 'graphjs-stylesheet';
		stylesheet.type = 'text/css';
		stylesheet.rel = 'stylesheet/less';
		stylesheet.href = response.status === 200 ? localFile : globalFile;
		// Append stylesheet
		document.head.appendChild(stylesheet);
		// Push stylesheet to LESS sheets
		less.sheets.push(document.getElementById('graphjs-stylesheet'));
		// Refresh Styles
		refreshStyles();
	});
}

// Refresh styles
const refreshStyles = () => {
	less.modifyVars({
		'@primary-color': window.GraphJSConfig['color'],
		'@text-color': window.GraphJSConfig['theme'].textColor,
		'@background-color': window.GraphJSConfig['theme'].backgroundColor
	});
}

// Get color
const getColor = (color) => {
	if(color.indexOf('rgb') !== -1) { // Check for rgb color value
		return color;
	} else if(color.charAt(0) === '#') { // Check for hex color value
		return color;
	} else if(/[0-9A-Fa-f]{6}/g.test(color)) { // Check for hex value & Convert to color
		return '#' + color;
	}
	return color; // Return everything else
}

// Get theme
const getTheme = (theme) => {
	let themes = {
		light: {
			primaryColor: '#6f879f',
			textColor: '#3f5f7f',
			backgroundColor: '#ffffff'
		},
		dark: {
			primaryColor: '#6f879f',
			textColor: '#ffffff',
			backgroundColor: '#474747'
		}
	}
	switch(typeof theme) {
	  case 'string':
	    if(theme === 'dark') {
				return themes.dark;
			} else {
				return themes.light;
			}
	    break;
		case 'object':
			// Check all colors & return value
			Object.keys(theme).map(key => theme[key] = getColor(theme[key]));
			return {
				...themes.light,
				...theme
			}
			break;
	  default:
	    return themes.light;
	}
}

// Init
const init = function(id, settings = {}) {

	window.GraphJSDefaultAvatar = 'https://raw.githubusercontent.com/phonetworks/graphjs/master/static/user.png';
	
	// Set config object
	window.GraphJSConfig = {};
	window.GraphJSConfig['id'] = id;
	window.GraphJSConfig['host'] = settings.host || 'https://build.phonetworks.com';
	window.GraphJSConfig['theme'] = getTheme(settings.theme || 'light');
	window.GraphJSConfig['color'] = getColor(settings.color || window.GraphJSConfig['theme']['primaryColor']);
	window.GraphJSConfig['streamId'] = settings.streamId || id.toUpperCase();
	window.GraphJSConfig['streamHost'] = settings.streamHost ? settings.streamHost.replace(/\/?$/, '/') : 'https://phostream.herokuapp.com/'; // Add a trailing slash in case it's absent
	window.GraphJSConfig['language'] = availableLanguages.includes(settings.language) ? settings.language : 'en-US';
	window.GraphJSConfig['defaultAvatar'] = settings.defaultAvatar || window.GraphJSDefaultAvatar;

	// Render theme
	renderTheme();
	// Login with token if there is any
	if(settings.token) {
		tokenLogin(settings.token, function(response) {
			console.log("logged in via token");
			riot.mount('*');
		});
		return;
	}
	// Mount tags
	riot.mount('*');
}

// General
import getId from './scripts/getId.js';

const graphJSObj={
    init,
    getId, // General
    languageData
};

options.modules.map(
    item_group => {
        import_tags[`${item_group}`].map(
            single_tag => import(/* webpackMode: "eager" */ `./tags/${single_tag}.tag`)
        );
        import_scripts[`${item_group}`].map(
            single_script => {
            	import(/* webpackMode: "eager" */ `./scripts/${single_script}.js`)
                    .then(single_script => graphJSObj[`${single_script}`]=single_script)
            }
        )
    }
);

function async_imports() {
    options.modules.map(
        item_group => {
            import_tags[`${item_group}`].map(
                async (single_tag) => {
                    let the_tag = await import(/* webpackMode: "eager" */ `./tags/${single_tag}.tag`);
                }
            );
            import_scripts[`${item_group}`].map(
                async (single_script) => {
                    let the_script = await import(/* webpackMode: "eager" */ `./scripts/${single_script}.js`);
                    graphJSObj[`${single_script}`]=the_script;
                }
            )
        }
    );
}
//async_imports();

window.GraphJS = graphJSObj;
window.GraphJS.events = new NanoEvents();
window.GraphJS.on = function(hook, callback) {
	window.GraphJS.events.on(hook, callback);
}