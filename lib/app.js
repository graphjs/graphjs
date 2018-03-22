// Riot
import riot from 'riot';
import 'riot-hot-reload';

// Tags
import './tags/overlay.tag';
import './tags/auth.tag';
import './tags/auth-login.tag';
import './tags/auth-register.tag';
import './tags/auth-reset.tag';
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-thread.tag';
import './tags/forum-compose.tag';
import './tags/state.tag';
import './tags/alert.tag';
import './tags/group-card.tag';
import './tags/profile.tag';
import './tags/profile-card.tag';
import './tags/profile-header.tag';
import './tags/profile-activity.tag';
import './tags/profile-followers.tag';
import './tags/profile-following.tag';
import './tags/profile-groups.tag';
import './tags/profile-settings.tag';
import './tags/messages.tag';
import './tags/comments.tag';
import './tags/bookmark-button.tag';

// Docs
import './docs/index.tag';
import './docs/tags/auth.tag';
import './docs/tags/auth-login.tag';
import './docs/tags/auth-register.tag';
import './docs/tags/auth-reset.tag';
import './docs/tags/forum.tag';
import './docs/tags/forum-list.tag';
import './docs/tags/forum-thread.tag';
import './docs/tags/forum-compose.tag';
import './docs/tags/state.tag';
import './docs/tags/alert.tag';
import './docs/tags/group-card.tag';
import './docs/tags/profile-card.tag';
import './docs/tags/messages.tag';
import './docs/tags/comments.tag';
import './docs/tags/bookmark-button.tag';

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

// Groups
import createGroup from './scripts/createGroup.js';
import joinGroup from './scripts/joinGroup.js';
import listGroups from './scripts/listGroups.js';
import listMembers from './scripts/listMembers.js';

// Forum
import getThread from './scripts/getThread.js';
import getThreads from './scripts/getThreads.js';
import replyThread from './scripts/replyThread.js';
import startThread from './scripts/startThread.js';

// Profile
import getProfile from './scripts/getProfile.js';
import setProfile from './scripts/setProfile.js';

// Show
import showAlertBox from './scripts/showAlertBox.js';
import showAuthBox from './scripts/showAuthBox.js';
import showCommentsBox from './scripts/showCommentsBox.js';
import showForumBox from './scripts/showForumBox.js';
// import showGroup from './scripts/showGroup.js';
import showLoginBox from './scripts/showLoginBox.js';
import showMessagesBox from './scripts/showMessagesBox.js';
import showOverlay from './scripts/showOverlay.js';
// import showProfile from './scripts/showProfile.js';
import showRegisterBox from './scripts/showRegisterBox.js';
import showResetBox from './scripts/showResetBox.js';

export {
	init,
	getUser, login, logout, register, reset, // Authentication
	bookmark, getBookmark, getBookmarks, removeBookmark, // Bookmark
	countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendMessage, // Messages
	createGroup, joinGroup, listGroups, listMembers, // Groups
	getThread, getThreads, replyThread, startThread, // Forum
	follow, getMembers, // Members
	getProfile, setProfile, // Profile
	showAlertBox, showAuthBox, showCommentsBox, showForumBox, /* showGroup, */ showLoginBox, showMessagesBox, showOverlay, /* showProfile, */ showRegisterBox, showResetBox // Show
}