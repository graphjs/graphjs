import './styles/common.less';

import loginCall from './login';
import signupCall from './signup';
import whoamiCall from './whoami';
import logoutCall from './logout';
import showLoginBoxCall from './showLoginBox';

import riot from 'riot';
import 'riot-hot-reload';

export function login() {
	loginCall(arguments);
};

export function signup() {
	signupCall(arguments);
};

export function whoami() {
	whoamiCall();
};

export function logout() {
	logoutCall();
};

export function showLoginBox() {
	showLoginBoxCall();
};

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