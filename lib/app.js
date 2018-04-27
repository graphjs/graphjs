// Riot
import riot from 'riot';
import 'riot-hot-reload';

// Tags
import './tags/overlay.tag';
import './tags/alert.tag';
import './tags/auth.tag';
import './tags/auth-login.tag';
import './tags/auth-register.tag';
import './tags/auth-reset.tag';
import './tags/star-button.tag';
import './tags/star-list.tag';
import './tags/comments.tag';
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-thread.tag';
import './tags/forum-compose.tag';
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
import './tags/state.tag';
import './tags/list.tag';

// Docs
import './docs/index.tag';
import './docs/tags/alert.tag';
import './docs/tags/auth.tag';
import './docs/tags/auth-login.tag';
import './docs/tags/auth-register.tag';
import './docs/tags/auth-reset.tag';
import './docs/tags/star-button.tag';
import './docs/tags/star-list.tag';
import './docs/tags/comments.tag';
import './docs/tags/forum.tag';
import './docs/tags/forum-list.tag';
import './docs/tags/forum-thread.tag';
import './docs/tags/forum-compose.tag';
import './docs/tags/group.tag';
import './docs/tags/group-card.tag';
import './docs/tags/messages.tag';
import './docs/tags/profile.tag';
import './docs/tags/profile-card.tag';
import './docs/tags/state.tag';
import './docs/tags/list.tag';

riot.mount('*');

// Init
const init = function(public_id) {
	window.status = public_id;
}

// Styles
import './styles/common.less';

// Activity
import getActivityToken from './scripts/getActivityToken.js';

// Authentication
import getUser from './scripts/getUser.js';
import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';

// Forum
import getThread from './scripts/getThread.js';
import getThreads from './scripts/getThreads.js';
import replyThread from './scripts/replyThread.js';
import startThread from './scripts/startThread.js';

// Groups
import createGroup from './scripts/createGroup.js';
import joinGroup from './scripts/joinGroup.js';
import listGroups from './scripts/listGroups.js';
import listMembers from './scripts/listMembers.js';

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
import showAuthLogin from './scripts/showLogin.js';
import showAuthRegister from './scripts/showRegister.js';
import showAuthReset from './scripts/showReset.js';
import showComments from './scripts/showComments.js';
import showForum from './scripts/showForum.js';
import showForumCompose from './scripts/showForumCompose.js';
import showForumList from './scripts/showForumList.js';
import showForumThread from './scripts/showForumThread.js';
import showGroup from './scripts/showGroup.js';
import showGroupCreator from './scripts/showGroupCreator.js';
import showMessages from './scripts/showMessages.js';
import showMessageComposer from './scripts/showMessageComposer.js';
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
	getUser, login, logout, register, reset, // Authentication
	getThread, getThreads, replyThread, startThread, // Forum
	createGroup, joinGroup, listGroups, listMembers, // Groups
	follow, getMembers, getFollowers, getFollowing, unfollow, // Members
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendMessage, // Messages
	getProfile, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, // Profile
	showAlert, showAuth, showAuthLogin, showAuthRegister, showAuthReset, showComments, showForum, showForumCompose, showForumList, showForumThread, showGroup, showGroupCreator, showMessageComposer, showMessages, showOverlay, showProfile, // Show
	star, getStar, getStars, getUserStars, removeStar // Star
}