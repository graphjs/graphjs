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
import './tags/list.tag';

// Docs
import './docs/index.tag';
import './docs/components/alert.tag';
import './docs/components/auth.tag';
import './docs/components/auth-state.tag';
import './docs/components/auth-login.tag';
import './docs/components/auth-register.tag';
import './docs/components/auth-reset.tag';
import './docs/components/star-button.tag';
import './docs/components/star-list.tag';
import './docs/components/comments.tag';
import './docs/components/forum.tag';
import './docs/components/forum-list.tag';
import './docs/components/forum-thread.tag';
import './docs/components/forum-composer.tag';
import './docs/components/group.tag';
import './docs/components/group-card.tag';
import './docs/components/messages.tag';
import './docs/components/messages-composer.tag';
import './docs/components/profile.tag';
import './docs/components/profile-card.tag';
import './docs/components/list.tag';
import './docs/functions/show/showAlert.tag';
import './docs/functions/show/showAuth.tag';
import './docs/functions/show/showLogin.tag';
import './docs/functions/show/showRegister.tag';
import './docs/functions/show/showReset.tag';
import './docs/functions/show/showComments.tag';
import './docs/functions/show/showForum.tag';
import './docs/functions/show/showForumList.tag';
import './docs/functions/show/showForumThread.tag';
import './docs/functions/show/showForumComposer.tag';
import './docs/functions/show/showMessages.tag';
import './docs/functions/show/showMessagesComposer.tag';
import './docs/functions/show/showProfile.tag';
import './docs/functions/show/showGroup.tag';
import './docs/functions/show/showGroupCreator.tag';
import './docs/functions/call/getActivityToken.tag';
import './docs/functions/call/getSession.tag';
import './docs/functions/call/getUser.tag';
import './docs/functions/call/login.tag';
import './docs/functions/call/logout.tag';
import './docs/functions/call/register.tag';
import './docs/functions/call/reset.tag';
//import './docs/functions/call/verify.tag';
import './docs/functions/call/addComment.tag';
import './docs/functions/call/getComments.tag';
import './docs/functions/call/removeComment.tag';
import './docs/functions/call/getThread.tag';
import './docs/functions/call/getThreads.tag';
import './docs/functions/call/removeReply.tag';
import './docs/functions/call/replyThread.tag';
import './docs/functions/call/startThread.tag';
import './docs/functions/call/createGroup.tag';
import './docs/functions/call/getGroup.tag';
import './docs/functions/call/joinGroup.tag';
import './docs/functions/call/leaveGroup.tag';
import './docs/functions/call/listGroups.tag';
import './docs/functions/call/listMembers.tag';
import './docs/functions/call/setGroupCover.tag';
import './docs/functions/call/setGroupDescription.tag';
import './docs/functions/call/setGroupTitle.tag';
import './docs/functions/call/follow.tag';
import './docs/functions/call/getFollowers.tag';
import './docs/functions/call/getFollowing.tag';
import './docs/functions/call/getMembers.tag';
import './docs/functions/call/unfollow.tag';
import './docs/functions/call/countUnreadMessages.tag';
import './docs/functions/call/getConversation.tag';
import './docs/functions/call/getConversations.tag';
import './docs/functions/call/getInbox.tag';
import './docs/functions/call/getMessage.tag';
import './docs/functions/call/getOutbox.tag';
import './docs/functions/call/sendMessage.tag';
import './docs/functions/call/getProfile.tag';
import './docs/functions/call/listMemberships.tag';
import './docs/functions/call/setAvatar.tag';
import './docs/functions/call/setBio.tag';
import './docs/functions/call/setBirthday.tag';
import './docs/functions/call/setEmail.tag';
import './docs/functions/call/setPassword.tag';
import './docs/functions/call/setProfile.tag';
import './docs/functions/call/setUsername.tag';
import './docs/functions/call/star.tag';
import './docs/functions/call/getStar.tag';
import './docs/functions/call/getStars.tag';
import './docs/functions/call/getUserStars.tag';
import './docs/functions/call/removeStar.tag';

// Init
const init = function(public_id, host) {
	host = host || 'http://phonetworks.com';
	window.status = public_id + ':' + host;
	riot.mount('*');
}

// Styles
import './styles/common.less';

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

export {
	init,
	getActivityToken, // Activity
	getSession, getUser, login, logout, register, reset, verify, // Authentication
	addComment, getComments, removeComment, //Comments
	getThread, getThreads, removeReply, replyThread, startThread, // Forum
	createGroup, getGroup, joinGroup, leaveGroup, listGroups, listMembers, setGroupCover, setGroupDescription, setGroupTitle, // Groups
	follow, getMembers, getFollowers, getFollowing, unfollow, // Members
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendMessage, // Messages
	getProfile, listMemberships, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, // Profile
	showAlert, showAuth, showLogin, showRegister, showReset, showComments, showForum, showForumComposer, showForumList, showForumThread, showGroup, showGroupCreator, showMessagesComposer, showMessages, showOverlay, showProfile, // Show
	star, getStar, getStars, getUserStars, removeStar // Star
}