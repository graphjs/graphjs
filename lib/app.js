// Riot
import riot from 'riot';
import 'riot-hot-reload';

// Tags
import './tags/overlay.tag';
import './tags/alert.tag';
import './tags/auth.tag';
import './tags/auth-state.tag';
import './tags/auth-login.tag';
import './tags/auth-register.tag';
import './tags/auth-reset.tag';
import './tags/star-button.tag';
import './tags/star-list.tag';
import './tags/comments.tag';
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

import './tags/messages.tag';
import './tags/messages-composer.tag';
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

// Color
import renderColor from './scripts/renderColor.js';

// Init
const init = function(id, settings) {
	let host = settings ? settings.host : undefined;
	let theme = settings ? settings.theme : undefined;
	let color = settings ? settings.color : undefined;
	window.GraphJSConfig = {};
	window.GraphJSConfig['id'] = id;
	window.GraphJSConfig['host'] = host || 'https://phonetworks.com';
	window.GraphJSConfig['theme'] = theme || 'light';
	window.GraphJSConfig['color'] = color || '#6f879f';
	document.body.className = document.body.className.replace(/\bgraphjs-theme\S+/ig, '');
	document.body.classList.add('graphjs-theme-' + window.GraphJSConfig['theme']);
	renderColor(window.GraphJSConfig['color']);
	riot.mount('*');
}

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

// Comments
import addComment from './scripts/addComment.js';
import getComments from './scripts/getComments.js';
import removeComment from './scripts/removeComment.js';

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
import showComments from './scripts/showComments.js';
import showForum from './scripts/showForum.js';
import showForumComposer from './scripts/showForumComposer.js';
import showForumList from './scripts/showForumList.js';
import showForumThread from './scripts/showForumThread.js';
import showGroup from './scripts/showGroup.js';
import showGroupCreator from './scripts/showGroupCreator.js';
import showMessages from './scripts/showMessages.js';
import showMessagesComposer from './scripts/showMessagesComposer.js';
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

window.GraphJS = {
	init,
	getActivityToken, // Activity
	getSession, getUser, login, logout, register, reset, verify, // Authentication
	addComment, getComments, removeComment, //Comments
	getThread, getThreads, removeReply, replyThread, startThread, // Forum
	createGroup, getGroup, joinGroup, leaveGroup, listGroups, listMembers, setGroupCover, setGroupDescription, setGroupTitle, // Groups
	follow, getMembers, getFollowers, getFollowing, unfollow, // Members
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendAnonymousMessage, sendMessage, // Messages
	getProfile, listMemberships, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, // Profile
	showAlert, showAuth, showLogin, showRegister, showReset, showComments, showForum, showForumComposer, showForumList, showForumThread, showGroup, showGroupCreator, showMessagesComposer, showMessages, showOverlay, showProfile, // Show
	star, getStar, getStars, getUserStars, removeStar, // Star
	getPrivateContent, addPrivateContent, removePrivateContent, editPrivateContent
}