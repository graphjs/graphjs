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
import './tags/bookmark-button.tag';
import './tags/bookmark-list.tag';
import './tags/comments.tag';
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-thread.tag';
import './tags/forum-compose.tag';
import './tags/group-card.tag';
import './tags/messages.tag';
import './tags/profile.tag';
import './tags/profile-card.tag';
import './tags/profile-header.tag';
import './tags/profile-activity.tag';
import './tags/profile-followers.tag';
import './tags/profile-following.tag';
import './tags/profile-groups.tag';
import './tags/profile-settings.tag';
import './tags/state.tag';

// Docs
import './docs/index.tag';
import './docs/tags/alert.tag';
import './docs/tags/auth.tag';
import './docs/tags/auth-login.tag';
import './docs/tags/auth-register.tag';
import './docs/tags/auth-reset.tag';
import './docs/tags/bookmark-button.tag';
import './docs/tags/bookmark-list.tag';
import './docs/tags/comments.tag';
import './docs/tags/forum.tag';
import './docs/tags/forum-list.tag';
import './docs/tags/forum-thread.tag';
import './docs/tags/forum-compose.tag';
import './docs/tags/group-card.tag';
import './docs/tags/messages.tag';
import './docs/tags/profile-card.tag';
import './docs/tags/state.tag';

riot.mount('*');

// Init
const init = function(public_id) {
	window.status = public_id;
}

// Styles
import './styles/common.less';

// Authentication
import getUser from './scripts/getUser.js';
import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';

// Bookmark
import bookmark from './scripts/bookmark.js';
import getBookmark from './scripts/getBookmark.js';
import getBookmarks from './scripts/getBookmarks.js';
import removeBookmark from './scripts/removeBookmark.js';

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
import getMembers from './scripts/getMembers.js';

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
import setProfile from './scripts/setProfile.js';

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
// import showGroup from './scripts/showGroup.js';
import showMessages from './scripts/showMessages.js';
import showOverlay from './scripts/showOverlay.js';
import showProfile from './scripts/showProfile.js';

export {
	init,
	getUser, login, logout, register, reset, // Authentication
	bookmark, getBookmark, getBookmarks, removeBookmark, // Bookmark
	getThread, getThreads, replyThread, startThread, // Forum
	createGroup, joinGroup, listGroups, listMembers, // Groups
	follow, getMembers, // Members
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendMessage, // Messages
	getProfile, setProfile, // Profile
	showAlert, showAuth, showAuthLogin, showAuthRegister, showAuthReset, showComments, showForum, showForumCompose, showForumList, showForumThread, /* showGroup, */ showMessages, showOverlay, showProfile // Show
}