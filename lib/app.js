import './styles/common.less';

import riot from 'riot';
import 'riot-hot-reload';

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