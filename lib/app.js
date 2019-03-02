// Riot
import riot from 'riot';
import 'riot-hot-reload';

// Tags
import './tags/promo.tag';
import './tags/file-upload.tag';
import './tags/overlay.tag';
import './tags/autocomplete.tag';
import './tags/alert.tag';
import './tags/auth.tag';
import './tags/auth-state.tag';
import './tags/auth-login.tag';
import './tags/auth-register.tag';
import './tags/auth-reset.tag';
import './tags/star-button.tag';
import './tags/star-list.tag';
import './tags/blog.tag';
import './tags/blog-list.tag';
import './tags/blog-post.tag';
import './tags/blog-composer.tag';
import './tags/comments.tag';
import './tags/feed.tag';
import './tags/feed-activity.tag';
import './tags/feed-composer.tag';
import './tags/feed-display.tag';
import './tags/feed-item.tag';
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-thread.tag';
import './tags/forum-composer.tag';
import './tags/group.tag';
import './tags/group-card.tag';
import './tags/group-creator.tag';
import './tags/group-header.tag';
import './tags/group-activity.tag';
import './tags/group-members.tag';
import './tags/group-settings.tag';
import './tags/input-text.tag';
import './tags/messages.tag';
import './tags/messages-composer.tag';
import './tags/notifications.tag';
import './tags/notifications-button.tag';
import './tags/notifications-list.tag';
import './tags/profile.tag';
import './tags/profile-card.tag';
import './tags/profile-header.tag';
import './tags/profile-activity.tag';
import './tags/profile-followers.tag';
import './tags/profile-following.tag';
import './tags/profile-groups.tag';
import './tags/profile-settings.tag';

import './tags/feedback.tag';
// import './tags/list.tag';
import './tags/group-list.tag';
import './tags/profile-list.tag';
import './tags/private-content.tag';

// Styles
import './styles/common.less';
import 'filepond/dist/filepond.css';

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

// Set theme
const setTheme = (theme) => {
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
	// Set config object
	window.GraphJSConfig = {};
	window.GraphJSConfig['id'] = id;
	window.GraphJSConfig['host'] = settings.host || 'https://build.phonetworks.com';
	window.GraphJSConfig['theme'] = settings.theme ? setTheme(settings.theme) : setTheme('light');
	window.GraphJSConfig['color'] = settings.color || window.GraphJSConfig['theme']['primaryColor'];
	window.GraphJSConfig['streamId'] = settings.streamId || id.toUpperCase();
	window.GraphJSConfig['streamHost'] = settings.streamHost ? settings.streamHost.replace(/\/?$/, '/') : 'https://phostream.herokuapp.com/'; // Add a trailing slash in case it's absent
	window.GraphJSConfig['language'] = availableLanguages.includes(settings.language) ? settings.language : 'en-US';
	window.GraphJSConfig['defaultAvatar'] = settings.defaultAvatar || 'https://raw.githubusercontent.com/phonetworks/graphjs/master/static/user.png';

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

// Activity
import getActivityToken from './scripts/getActivityToken.js';

// Authentication
import getSession from './scripts/getSession.js';
import getUser from './scripts/getUser.js';
import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';
import verify from './scripts/verify.js';

// Blog
import commentBlogPost from './scripts/commentBlogPost.js';
import editBlogPost from './scripts/editBlogPost.js';
import editBlogComment from './scripts/editBlogComment.js';
import getBlogPost from './scripts/getBlogPost.js';
import getBlogPosts from './scripts/getBlogPosts.js';
import publishBlogPost from './scripts/publishBlogPost.js';
import removeBlogPost from './scripts/removeBlogPost.js';
import removeBlogComment from './scripts/removeBlogComment.js';
import startBlogPost from './scripts/startBlogPost.js';
import unpublishBlogPost from './scripts/unpublishBlogPost.js';

// Comments
import addComment from './scripts/addComment.js';
import getComments from './scripts/getComments.js';
import removeComment from './scripts/removeComment.js';

// Feed
import getStatusUpdates from './scripts/getStatusUpdates.js';
import getStatusUpdate from './scripts/getStatusUpdate.js';
import updateStatus from './scripts/updateStatus.js';
import removeStatusUpdate from './scripts/removeStatusUpdate.js';

// Forum
import getThread from './scripts/getThread.js';
import getThreads from './scripts/getThreads.js';
import removeReply from './scripts/removeReply.js';
import replyThread from './scripts/replyThread.js';
import startThread from './scripts/startThread.js';

// Groups
import createGroup from './scripts/createGroup.js';
import getGroup from './scripts/getGroup.js';
import joinGroup from './scripts/joinGroup.js';
import leaveGroup from './scripts/leaveGroup.js';
import listGroups from './scripts/listGroups.js';
import listMembers from './scripts/listMembers.js';
import setGroupCover from './scripts/setGroupCover.js';
import setGroupDescription from './scripts/setGroupDescription.js';
import setGroupTitle from './scripts/setGroupTitle.js';

// Members
import follow from './scripts/follow.js';
import getFollowers from './scripts/getFollowers.js';
import getFollowing from './scripts/getFollowing.js';
import getMembers from './scripts/getMembers.js';
import unfollow from './scripts/unfollow.js';

// Messages
import countUnreadMessages from './scripts/countUnreadMessages.js';
import getConversation from './scripts/getConversation.js';
import getConversations from './scripts/getConversations.js';
import getInbox from './scripts/getInbox.js';
import getMessage from './scripts/getMessage.js';
import getOutbox from './scripts/getOutbox.js';
import sendAnonymousMessage from './scripts/sendAnonymousMessage.js';
import sendMessage from './scripts/sendMessage.js';

// Notifications
import getNotifications from './scripts/getNotifications.js';

// Profile
import getProfile from './scripts/getProfile.js';
import listMemberships from './scripts/listMemberships.js';
import setAvatar from './scripts/setAvatar.js';
import setBio from './scripts/setBio.js';
import setBirthday from './scripts/setBirthday.js';
import setEmail from './scripts/setEmail.js';
import setPassword from './scripts/setPassword.js';
import setProfile from './scripts/setProfile.js';
import setUsername from './scripts/setUsername.js';

// Show
import showAlert from './scripts/showAlert.js';
import showAuth from './scripts/showAuth.js';
import showLogin from './scripts/showLogin.js';
import showRegister from './scripts/showRegister.js';
import showReset from './scripts/showReset.js';
import showBlog from './scripts/showBlog.js';
import showBlogComposer from './scripts/showBlogComposer.js';
import showBlogList from './scripts/showBlogList.js';
import showBlogPost from './scripts/showBlogPost.js';
import showComments from './scripts/showComments.js';
import showFeedItem from './scripts/showFeedItem.js';
import showForum from './scripts/showForum.js';
import showForumComposer from './scripts/showForumComposer.js';
import showForumList from './scripts/showForumList.js';
import showForumThread from './scripts/showForumThread.js';
import showGroup from './scripts/showGroup.js';
import showGroupCreator from './scripts/showGroupCreator.js';
import showMessages from './scripts/showMessages.js';
import showMessagesComposer from './scripts/showMessagesComposer.js';
import showNotificationsList from './scripts/showNotificationsList.js';
import showOverlay from './scripts/showOverlay.js';
import showProfile from './scripts/showProfile.js';

// Star
import star from './scripts/star.js';
import getStar from './scripts/getStar.js';
import getStars from './scripts/getStars.js';
import getUserStars from './scripts/getUserStars.js';
import removeStar from './scripts/removeStar.js';

import getPrivateContent from './scripts/getPrivateContent.js';
import removePrivateContent from './scripts/removePrivateContent.js';
import editPrivateContent from './scripts/editPrivateContent.js';
import addPrivateContent from './scripts/addPrivateContent.js';

// Stripe
import createSubscription from './scripts/createSubscription.js';
import checkSubscription from './scripts/checkSubscription.js';
import tokenLogin from './scripts/tokenLogin.js';

window.GraphJS = {
	init,
	getId, // General
	getActivityToken, // Activity
	getSession, getUser, login, logout, register, reset, verify, // Authentication
	editBlogPost, editBlogComment, getBlogPost, getBlogPosts, removeBlogPost, removeBlogComment, commentBlogPost, startBlogPost, publishBlogPost, unpublishBlogPost,// Blog
	addComment, getComments, removeComment, //Comments
	getStatusUpdates, getStatusUpdate, updateStatus, removeStatusUpdate, // Feed
	getThread, getThreads, removeReply, replyThread, startThread, // Forum
	createGroup, getGroup, joinGroup, leaveGroup, listGroups, listMembers, setGroupCover, setGroupDescription, setGroupTitle, // Groups
	follow, getMembers, getFollowers, getFollowing, unfollow, // Members
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendAnonymousMessage, sendMessage, // Messages
	getProfile, listMemberships, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, // Profile
	showAlert, showAuth, showLogin, showRegister, showReset, showBlog, showBlogComposer, showBlogList, showBlogPost, showComments, showFeedItem, showForum, showForumComposer, showForumList, showForumThread, showGroup, showGroupCreator, showMessagesComposer, showMessages, showNotificationsList, showOverlay, showProfile, // Show
	star, getStar, getStars, getUserStars, removeStar, // Star
	getPrivateContent, addPrivateContent, removePrivateContent, editPrivateContent,
	checkSubscription, createSubscription, // Stripe
	languageData
};

window.GraphJS.events = new NanoEvents();
window.GraphJS.on = function(hook, callback) {
	window.GraphJS.events.on(hook, callback);
}