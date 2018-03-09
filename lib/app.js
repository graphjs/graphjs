// Riot
import riot from 'riot';
import 'riot-hot-reload';

// Riot Tags
import './tags/auth.tag';
import './tags/auth-login.tag';
import './tags/auth-register.tag';
import './tags/auth-reset.tag';
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-entry.tag';
import './tags/forum-compose.tag';
import './tags/state.tag';
import './tags/alert.tag';
import './tags/group-card.tag';
import './tags/profile-card.tag';
import './tags/messages.tag';

riot.mount('*');

// Styles
import './styles/common.less';

// Authentication
import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';
import whoami from './scripts/whoami.js';
import showLoginBox from './scripts/showLoginBox.js';

// Profile
import getProfile from './scripts/getProfile.js';
import setProfile from './scripts/setProfile.js';

// Messages
import message from './scripts/message.js';
import fetchInbox from './scripts/fetchInbox.js';
import fetchOutbox from './scripts/fetchOutbox.js';
import fetchMessage from './scripts/fetchMessage.js';
import fetchUnreadMessageCount from './scripts/fetchUnreadMessageCount.js';

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

// Star
import star from './scripts/star.js';
import fetchStarredContent from './scripts/fetchStarredContent.js';