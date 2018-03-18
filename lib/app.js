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
import './tags/profile-card.tag';
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

// Styles
import './styles/common.less';

// Authentication
import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';
import getUser from './scripts/getUser.js';
import showLoginBox from './scripts/showLoginBox.js';

// Profile
import getProfile from './scripts/getProfile.js';
import setProfile from './scripts/setProfile.js';

// Messages
import sendMessage from './scripts/sendMessage.js';
import getInbox from './scripts/getInbox.js';
import getOutbox from './scripts/getOutbox.js';
import getMessage from './scripts/getMessage.js';
import countUnreadMessages from './scripts/countUnreadMessages.js';

// Groups
import createGroup from './scripts/createGroup.js';
import joinGroup from './scripts/joinGroup.js';
import listGroups from './scripts/listGroups.js';
import listMembers from './scripts/listMembers.js';

// Forum
import getThread from './scripts/getThread.js';
import getThreads from './scripts/getThreads.js';
import startThread from './scripts/startThread.js';
import replyThread from './scripts/replyThread.js';

// Bookmark
import bookmark from './scripts/bookmark.js';
import getBookmarks from './scripts/getBookmarks.js';

var init = function(public_id) {
	window.status = public_id;
}

export {
	login, logout, register, init, getInbox, createGroup, getUser, listGroups, getProfile, getThreads
}