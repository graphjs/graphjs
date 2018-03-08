import './styles/common.less';

import riot from 'riot';
import 'riot-hot-reload';

import login from './scripts/login.js';
import logout from './scripts/logout.js';
import register from './scripts/register.js';
import reset from './scripts/reset.js';
import whoami from './scripts/whoami.js';

import showLoginBox from './scripts/showLoginBox.js';

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