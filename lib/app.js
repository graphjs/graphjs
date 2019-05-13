// Riot
import riot from 'riot';
import 'riot-hot-reload';
const options={
	modules: [
		//"activity",
		//"authentication",
		//"blog",
		//"comments",
        //"feed",
		//"forum",
		//"groups",
		//"members",
		"messages",
		"notifications",
		//"profile",
		//"show",
		//"star",
		//"private",
		//"stripe"
	]
};

const functions={
    activity: async function (){
         const [getActivityToken] =
             await Promise.all([
                 import(/* webpackMode: "eager" */ `./scripts/getActivityToken.js`),
             ]);
         graphJSObj.getActivityToken=getActivityToken;
     },
    authentication: async function (){
            const [auth, authState, authLogin, authRegister, authReset,
                getSession, getUser, login, logout, register, reset,
                verify, showAlert, showAuth, showLogin, showRegister, showReset,
            ] = await Promise.all([
                    import(/* webpackMode: "eager" */ `./tags/auth.tag`),
                    import(/* webpackMode: "eager" */ `./tags/auth-state.tag`),
                    import(/* webpackMode: "eager" */ `./tags/auth-login.tag`),
                    import(/* webpackMode: "eager" */ `./tags/auth-register.tag`),
                    import(/* webpackMode: "eager" */ `./tags/auth-reset.tag`),
                    import(/* webpackMode: "eager" */ `./scripts/getSession.js`),
                    import(/* webpackMode: "eager" */ `./scripts/login.js`),
                    import(/* webpackMode: "eager" */ `./scripts/getUser.js`),
                    import(/* webpackMode: "eager" */ `./scripts/logout.js`),
                    import(/* webpackMode: "eager" */ `./scripts/register.js`),
                    import(/* webpackMode: "eager" */ `./scripts/reset.js`),
                    import(/* webpackMode: "eager" */ `./scripts/verify.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showAlert.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showAuth.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showLogin.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showRegister.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showReset.js`),
                ]);
            graphJSObj.getSession=getSession;
            graphJSObj.getUser=getUser;
            graphJSObj.login=login;
            graphJSObj.logout=logout;
            graphJSObj.register=register;
            graphJSObj.reset=reset;
            graphJSObj.verify=verify;
            graphJSObj.showAlert=showAlert;
            graphJSObj.showAuth=showAuth;
            graphJSObj.showLogin=showLogin;
            graphJSObj.showRegister=showRegister;
            graphJSObj.showReset=showReset;

    },
    blog: async function (){
            const [blog, blogList, blogPost,
                commentBlogPost, editBlogPost, editBlogComment,
                getBlogComments, getBlogPost, getBlogPosts,
                removeBlogPost, removeBlogComment, startBlogPost,
                unpublishBlogPost, showBlog, showBlogComposer, showBlogList, showBlogPost
            ] =
                await Promise.all([
                    import(/* webpackMode: "eager" */ `./tags/blog.tag`),
                    import(/* webpackMode: "eager" */ `./tags/blog-list.tag`),
                    import(/* webpackMode: "eager" */ `./tags/blog-post.tag`),
                    import(/* webpackMode: "eager" */ `./scripts/commentBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/editBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/editBlogComment.js`),
                    import(/* webpackMode: "eager" */ `./scripts/getBlogComments.js`),
                    import(/* webpackMode: "eager" */ `./scripts/getBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/getBlogPosts.js`),
                    import(/* webpackMode: "eager" */ `./scripts/removeBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/removeBlogComment.js`),
                    import(/* webpackMode: "eager" */ `./scripts/startBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/unpublishBlogPost.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showBlog.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showBlogComposer.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showBlogList.js`),
                    import(/* webpackMode: "eager" */ `./scripts/showBlogPost.js`),
                ]);
            graphJSObj.commentBlogPost = commentBlogPost;
            graphJSObj.editBlogPost = editBlogPost;
            graphJSObj.editBlogComment = editBlogComment;
            graphJSObj.getBlogComments = getBlogComments;
            graphJSObj.getBlogPost = getBlogPost;
            graphJSObj.getBlogPosts = getBlogPosts;
            graphJSObj.removeBlogPost = removeBlogPost;
            graphJSObj.removeBlogComment = removeBlogComment;
            graphJSObj.startBlogPost = startBlogPost;
            graphJSObj.unpublishBlogPost = unpublishBlogPost;
            graphJSObj.showBlog = showBlog;
            graphJSObj.showBlogComposer = showBlogComposer;
            graphJSObj.showBlogList = showBlogList;
            graphJSObj.showBlogPost = showBlogPost;
     },
    comments: async function (){
        const [comments,
            addComment,
            getComments,
            removeComment,
            showComments,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/comments.tag`),
                import(/* webpackMode: "eager" */ `./scripts/addComment.js`),
                import(/* webpackMode: "eager" */ `./scripts/getComments.js`),
                import(/* webpackMode: "eager" */ `./scripts/removeComment.js`),
                import(/* webpackMode: "eager" */ `./scripts/showComments.js`),
            ]);
        graphJSObj.addComment=addComment;
        graphJSObj.getComments=getComments;
        graphJSObj.removeComment=removeComment;
        graphJSObj.showComments=showComments;
    },
    feed: async function (){
        const [
            feed,
            feedActivity,
            feedComposer,
            feedDisplay,
            feedItem,
            getStatusUpdates,
            getStatusUpdate,
            updateStatus,
            removeStatusUpdate,
            showFeedItem,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/feed.tag`),
                import(/* webpackMode: "eager" */ `./tags/feed-activity.tag`),
                import(/* webpackMode: "eager" */ `./tags/feed-composer.tag`),
                import(/* webpackMode: "eager" */ `./tags/feed-display.tag`),
                import(/* webpackMode: "eager" */ `./tags/feed-item.tag`),
                import(/* webpackMode: "eager" */ `./scripts/getStatusUpdates.js`),
                import(/* webpackMode: "eager" */ `./scripts/getStatusUpdate.js`),
                import(/* webpackMode: "eager" */ `./scripts/updateStatus.js`),
                import(/* webpackMode: "eager" */ `./scripts/removeStatusUpdate.js`),
                import(/* webpackMode: "eager" */ `./scripts/showFeedItem.js`),
            ]);
        graphJSObj.getStatusUpdates=getStatusUpdates;
        graphJSObj.getStatusUpdate=getStatusUpdate;
        graphJSObj.updateStatus=updateStatus;
        graphJSObj.removeStatusUpdate=removeStatusUpdate;
        graphJSObj.showFeedItem=showFeedItem;
    },
    forum: async function (){
        const [
            forum,
            forumList,
            forumThread,
            forumComposer,
            getThread,
            getThreads,
            removeReply,
            replyThread,
            startThread,
            showForum,
            showForumComposer,
            showForumList,
            showForumThread,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/forum.tag`),
                import(/* webpackMode: "eager" */ `./tags/forum-list.tag`),
                import(/* webpackMode: "eager" */ `./tags/forum-thread.tag`),
                import(/* webpackMode: "eager" */ `./tags/forum-composer.tag`),
                import(/* webpackMode: "eager" */ `./scripts/getThread.js`),
                import(/* webpackMode: "eager" */ `./scripts/getThreads.js`),
                import(/* webpackMode: "eager" */ `./scripts/removeReply.js`),
                import(/* webpackMode: "eager" */ `./scripts/replyThread.js`),
                import(/* webpackMode: "eager" */ `./scripts/startThread.js`),
                import(/* webpackMode: "eager" */ `./scripts/showForum.js`),
                import(/* webpackMode: "eager" */ `./scripts/showForumComposer.js`),
                import(/* webpackMode: "eager" */ `./scripts/showForumList.js`),
                import(/* webpackMode: "eager" */ `./scripts/showForumThread.js`),
            ]);
        graphJSObj.getThread=getThread;
        graphJSObj.getThreads=getThreads;
        graphJSObj.removeReply=removeReply;
        graphJSObj.replyThread=replyThread;
        graphJSObj.startThread=startThread;
        graphJSObj.showForum=showForum;
        graphJSObj.showForumComposer=showForumComposer;
        graphJSObj.showForumList=showForumList;
        graphJSObj.showForumThread=showForumThread;
    },
    groups: async function (){
        const [
            group,
            groupCard,
            groupCreator,
            groupHeader,
            groupActivity,
            groupMembers,
            groupSettings,
            groupList,
            createGroup,
            getGroup,
            joinGroup,
            leaveGroup,
            listGroups,
            listMembers,
            setGroupCover,
            setGroupDescription,
            setGroupTitle,
            showGroup,
            showGroupCreator,
            ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/group.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-card.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-creator.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-header.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-activity.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-members.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-settings.tag`),
                import(/* webpackMode: "eager" */ `./tags/group-list.tag`),
                import(/* webpackMode: "eager" */ `./scripts/createGroup.js`),
                import(/* webpackMode: "eager" */ `./scripts/getGroup.js`),
                import(/* webpackMode: "eager" */ `./scripts/joinGroup.js`),
                import(/* webpackMode: "eager" */ `./scripts/leaveGroup.js`),
                import(/* webpackMode: "eager" */ `./scripts/listGroups.js`),
                import(/* webpackMode: "eager" */ `./scripts/listMembers.js`),
                import(/* webpackMode: "eager" */ `./scripts/setGroupCover.js`),
                import(/* webpackMode: "eager" */ `./scripts/setGroupDescription.js`),
                import(/* webpackMode: "eager" */ `./scripts/setGroupTitle.js`),
                import(/* webpackMode: "eager" */ `./scripts/showGroup.js`),
                import(/* webpackMode: "eager" */ `./scripts/showGroupCreator.js`),
            ]);
        graphJSObj.createGroup=createGroup;
        graphJSObj.getGroup=getGroup;
        graphJSObj.joinGroup=joinGroup;
        graphJSObj.leaveGroup=leaveGroup;
        graphJSObj.listGroups=listGroups;
        graphJSObj.listMembers=listMembers;
        graphJSObj.setGroupCover=setGroupCover;
        graphJSObj.setGroupDescription=setGroupDescription;
        graphJSObj.setGroupTitle=setGroupTitle;
        graphJSObj.showGroup=showGroup;
        graphJSObj.showGroupCreator=showGroupCreator;
    },
    members: async function (){
        const [
            follow,
            getFollowers,
            getFollowing,
            getMembers,
            unfollow,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./scripts/follow.js`),
                import(/* webpackMode: "eager" */ `./scripts/getFollowers.js`),
                import(/* webpackMode: "eager" */ `./scripts/getFollowing.js`),
                import(/* webpackMode: "eager" */ `./scripts/getMembers.js`),
                import(/* webpackMode: "eager" */ `./scripts/unfollow.js`),
            ]);
        graphJSObj.follow=follow;
        graphJSObj.getFollowers=getFollowers;
        graphJSObj.getFollowing=getFollowing;
        graphJSObj.getMembers=getMembers;
        graphJSObj.unfollow=unfollow;
    },
    messages: async function (){
        const [messages, messagesComposer,
            countUnreadMessages,
            getConversation,
            getConversations,
            getInbox,
            getMessage,
            getOutbox,
            sendAnonymousMessage,
            sendMessage,
            showMessages,
            showMessagesComposer,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/messages.tag`),
                import(/* webpackMode: "eager" */ `./tags/messages-composer.tag`),
                import(/* webpackMode: "eager" */ `./scripts/countUnreadMessages.js`),
                import(/* webpackMode: "eager" */ `./scripts/getConversation.js`),
                import(/* webpackMode: "eager" */ `./scripts/getConversations.js`),
                import(/* webpackMode: "eager" */ `./scripts/getInbox.js`),
                import(/* webpackMode: "eager" */ `./scripts/getMessage.js`),
                import(/* webpackMode: "eager" */ `./scripts/getOutbox.js`),
                import(/* webpackMode: "eager" */ `./scripts/sendAnonymousMessage.js`),
                import(/* webpackMode: "eager" */ `./scripts/sendMessage.js`),
                import(/* webpackMode: "eager" */ `./scripts/showMessages.js`),
                import(/* webpackMode: "eager" */ `./scripts/showMessagesComposer.js`),
            ]);
        graphJSObj.countUnreadMessages=countUnreadMessages;
        graphJSObj.getConversation=getConversation;
        graphJSObj.getConversations=getConversations;
        graphJSObj.getInbox=getInbox;
        graphJSObj.getMessage=getMessage;
        graphJSObj.getOutbox=getOutbox;
        graphJSObj.sendAnonymousMessage=sendAnonymousMessage;
        graphJSObj.sendMessage=sendMessage;
        graphJSObj.showMessages=showMessages;
        graphJSObj.showMessagesComposer=showMessagesComposer;
    },
    notifications: async function (){
         const [notifications, notificationsButton, notificationsList, getNotifications, showNotificationsList] =
             await Promise.all([
                 import(/* webpackMode: "eager" */ `./tags/notifications.tag`),
                 import(/* webpackMode: "eager" */ `./tags/notifications-button.tag`),
                 import(/* webpackMode: "eager" */ `./tags/notifications-list.tag`),
                 import(/* webpackMode: "eager" */ `./scripts/getNotifications.js`),
                 import(/* webpackMode: "eager" */ `./scripts/showNotificationsList.js`)
             ]);
         graphJSObj.getNotifications=getNotifications;
         graphJSObj.showNotificationsList=showNotificationsList;
     },
    profile: async function (){
        const [
            profile,
            profileCards,
            profileHeader,
            profileActivity,
            profileFollowers,
            profileFollowing,
            profileGroups,
            profileSettings,
            profileList,
            getProfile,
            listMemberships,
            setAvatar,
            setBio,
            setBirthday,
            setEmail,
            setPassword,
            setProfile,
            setUsername,
            showProfile,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/profile.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-card.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-header.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-activity.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-followers.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-following.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-groups.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-settings.tag`),
                import(/* webpackMode: "eager" */ `./tags/profile-list.tag`),
                import(/* webpackMode: "eager" */ `./scripts/getProfile.js`),
                import(/* webpackMode: "eager" */ `./scripts/listMemberships.js`),
                import(/* webpackMode: "eager" */ `./scripts/setAvatar.js`),
                import(/* webpackMode: "eager" */ `./scripts/setBio.js`),
                import(/* webpackMode: "eager" */ `./scripts/setBirthday.js`),
                import(/* webpackMode: "eager" */ `./scripts/setEmail.js`),
                import(/* webpackMode: "eager" */ `./scripts/setPassword.js`),
                import(/* webpackMode: "eager" */ `./scripts/setProfile.js`),
                import(/* webpackMode: "eager" */ `./scripts/setUsername.js`),
                import(/* webpackMode: "eager" */ `./scripts/showProfile.js`),
            ]);
        graphJSObj.getProfile=getProfile;
        graphJSObj.listMemberships=listMemberships;
        graphJSObj.setAvatar=setAvatar;
        graphJSObj.setBio=setBio;
        graphJSObj.setBirthday=setBirthday;
        graphJSObj.setEmail=setEmail;
        graphJSObj.setPassword=setPassword;
        graphJSObj.setProfile=setProfile;
        graphJSObj.setUsername=setUsername;
        graphJSObj.showProfile=showProfile;
    },
    show: async function (){
        const [showOverlay] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./scripts/showOverlay.js`),
            ]);
        graphJSObj.showOverlay=showOverlay;
    },
    star: async function (){
        const [starButton, starList,
            star,
            getStar,
            getStars,
            getUserStars,
            removeStar,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/star-button.tag`),
                import(/* webpackMode: "eager" */ `./tags/star-list.tag`),
                import(/* webpackMode: "eager" */ `./scripts/star.js`),
                import(/* webpackMode: "eager" */ `./scripts/getStar.js`),
                import(/* webpackMode: "eager" */ `./scripts/getStars.js`),
                import(/* webpackMode: "eager" */ `./scripts/getUserStars.js`),
                import(/* webpackMode: "eager" */ `./scripts/removeStar.js`),
            ]);
        graphJSObj.star=star;
        graphJSObj.getStar=getStar;
        graphJSObj.getStars=getStars;
        graphJSObj.getUserStars=getUserStars;
        graphJSObj.removeStar=removeStar;

    },
    private: async function (){
        const [privateContent,
            getPrivateContent,
            removePrivateContent,
            editPrivateContent,
            addPrivateContent,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./tags/private-content.tag`),
                import(/* webpackMode: "eager" */ `./scripts/getPrivateContent.js`),
                import(/* webpackMode: "eager" */ `./scripts/removePrivateContent.js`),
                import(/* webpackMode: "eager" */ `./scripts/editPrivateContent.js`),
                import(/* webpackMode: "eager" */ `./scripts/addPrivateContent.js`),
            ]);
        graphJSObj.getPrivateContent=getPrivateContent;
        graphJSObj.removePrivateContent=removePrivateContent;
        graphJSObj.editPrivateContent=editPrivateContent;
        graphJSObj.addPrivateContent=addPrivateContent;
    },
    stripe: async function (){
        const [
            createSubscription,
            checkSubscription,
            tokenLogin,
        ] =
            await Promise.all([
                import(/* webpackMode: "eager" */ `./scripts/createSubscription.js`),
                import(/* webpackMode: "eager" */ `./scripts/checkSubscription.js`),
                import(/* webpackMode: "eager" */ `./scripts/tokenLogin.js`),
            ]);
        graphJSObj.createSubscription=createSubscription;
        graphJSObj.checkSubscription=checkSubscription;
        graphJSObj.tokenLogin=tokenLogin;
    },
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


for(let i=0; i<options.modules.length; ++i){
    let f_name=options.modules[i];
    functions[f_name]();
}

window.GraphJS = graphJSObj;
window.GraphJS.events = new NanoEvents();
window.GraphJS.on = function(hook, callback) {
	window.GraphJS.events.on(hook, callback);
}