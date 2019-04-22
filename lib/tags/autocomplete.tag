<graphjs-autocomplete
    class="graphjs-element graphjs-root graphjs-box"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '') +
        (opts.top ? 'top: ' + opts.top + '; ' : '') +
        (opts.left ? 'left: ' + opts.left + '; ' : '') +
        (opts.width ? 'width: ' + opts.width + '; ' : '')
    }
>
    <div class={'graphjs-content' + (closing ? ' graphjs-closable' : '')}>
        <div class={'graphjs-input' + (loaded ? '' : ' graphjs-loading')}>
            <div if={loaded && symbol} class="graphjs-symbol">
                <b if={type === 'users' || type === 'members'}>@</b>
                <b if={type === 'groups'}>#</b>
            </div>
            <input if={loaded && list.length > 0} ref="input" placeholder={inputPlaceholder} type="text" onkeyup={handleInput} style={loaded ? '' : 'visibility: hidden;'}>
            <a if={closing} class="graphjs-close">
                <svg viewBox="15 15 70 70">
                    <path d="M19.8,80.2c1.6,1.6,3.6,2.3,5.7,2.3s4.1-0.8,5.7-2.3L50,61.3l18.8,18.8c1.6,1.6,3.6,2.3,5.7,2.3s4.1-0.8,5.7-2.3   c3.1-3.1,3.1-8.2,0-11.3L61.3,50l18.8-18.8c3.1-3.1,3.1-8.2,0-11.3c-3.1-3.1-8.2-3.1-11.3,0L50,38.7L31.2,19.8   c-3.1-3.1-8.2-3.1-11.3,0c-3.1,3.1-3.1,8.2,0,11.3L38.7,50L19.8,68.8C16.7,72,16.7,77,19.8,80.2z"/>
                </svg>
            </a>
            <div if={!loaded && !blocked} class="graphjs-loader">
                <div class="graphjs-dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
        <div
            class="graphjs-results"
            if={loaded && data && matchedItems.length > 0}
            style={opts.limit ? 'max-height: calc((' + limit + ' * 2em) + .5em);' : ''}>
            <a each={matchedItem in matchedItems} class="graphjs-item" data-id={matchedItem} data-label={data[matchedItem].label} onclick={handleCallback}>
                <img if={type === 'users' || type === 'members'} src={data[matchedItem].image ? downsizeImage(data[matchedItem].image, 40) : defaultAvatar} /> <!-- gravatar todo -->
                <b>{data[matchedItem].label}</b>
            </a>
        </div>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import listMembers from '../scripts/listMembers.js';
        import getSession from '../scripts/getSession.js';
        import getProfile from '../scripts/getProfile.js';

        import gravatar from 'gravatar';
        this.gravatar = gravatar;

        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.defaultAvatar = opts.defaultAvatar || window.GraphJSConfig.defaultAvatar;

        analytics('autocomplete');

        let self = this;

        this.type = opts.type || 'users';
        this.symbol = !(opts.symbol === 'disabled');
        this.limit = opts.limit || 10;
        this.list = [];
        this.matchedItems = [];
        this.data = {};
        this.loaded = false;
        this.closing = opts.closing === 'on';
        this.inputPlaceholder = 'Type a name';

        this.on('before-mount', function() {
            this.handleAccess();
        });
        this.on('mount', function() {
            opts.autoclose && document.addEventListener('click', self.handleAutoclose);
        });
        this.on('unmount', function() {
            clearInterval(this.placeholderTextUpdater);
            opts.autoclose && document.removeEventListener('click', self.handleAutoclose);
        });

        this.restart = () => {
            this.loaded = false;
            this.blocked = false;
            this.list = [];
            this.matchedItems = [];
            this.data = {};
            this.update();
            this.handleAccess();
        }
        this.handleAccess = () => {
            opts.access == 'private'
            ? this.handleUser()
            : this.handleContent();
        }
        this.handleUser = () => {
            getSession(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                    self.handleContent();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
        this.handleContent = () => {
            switch(this.type) {
                case 'users':
                    self.handleUsersList();
                    break;
                case 'groups':
                    self.handleGroupsList();
                    break;
                case 'members':
                    self.handleMembersList();
                    break;
            }
        }
        this.handleUsersList = () => {
            getMembers(function(response) {
                if(response.success) {
                    self.list = Object.keys(response.members);
                    self.empty = self.list.length === 0;
                    self.handleProfiles();
                } else {
                    //Handle error
                }
            });
        }
        this.handleGroupsList = () => {
            listGroups(function(response) {
                if(response.success) {
                    response.groups.forEach((group, index) => {
                        let id = group.id;
                        self.list.push(id);
                        self.empty = self.list.length === 0;
                        self.data[id] = {};
                        self.data[id].label = group.title;
                        if(index === response.groups.length - 1) self.loaded = true;
                    });
                    self.update();
                    self.updatePlaceholderText();
                    self.handleAutofocus();
                } else {
                    //Handle error
                }
            });
        }
        this.handleMembersList = () => {
            listMembers(function(response) {
                if(response.success) {
                    self.list = Object.keys(response.members);
                    self.empty = self.list.length === 0;
                    self.handleProfiles();
                } else {
                    //Handle error
                }
            });
        }
        this.handleProfiles = () => {
            self.list.forEach((id, index) => {
                getProfile(id, function(response) {
                    if(response.success) {
                        self.data[id] = {};
                        self.data[id].label = response.profile.username;
                        self.data[id].image = response.profile.avatar;
                    }
                });
                if(index === self.list.length - 1) {
                    self.loaded = true;
                }
            });
            self.update();
            self.updatePlaceholderText();
            self.handleAutofocus();
        }
        this.handleAutofocus = () => {
            this.refs.input.focus();
        }
        this.handleInput = (event) => {
            if(event.keyCode == 13) {
                this.handleCallback(event);
            } else {
                this.handleFilter(event);
            }
        }
        this.handleFilter = (event) => {
            let input = this.refs.input.value;
            self.matchedItems = input.length > 0
                ? self.list.filter(item => {
                    return self.data[item].label.toLowerCase().startsWith(input.toLowerCase());
                })
                : [];
            self.update();
        }
        this.updatePlaceholderText = () => {
            if(this.list.length > 0) {
                this.placeholderTextUpdater = setInterval(function() {
                    let randomNumber = Math.floor(Math.random() * self.list.length);
                    self.refs.input.placeholder = self.data[self.list[randomNumber]].label;
                    self.update();
                }, 2500);
            }
        }
        this.handleCallback = (event) => {
            let input = this.refs.input.value;
            let id, label;
            event.preventDefault();
            if(event.currentTarget.type === 'text') {
                Object.keys(this.data).forEach(key => {
                    if(this.data[key].label.toLowerCase() === input.toLowerCase()) id = key;
                });
                label = input;
            } else {
                id = event.currentTarget.dataset.id;
                label = event.currentTarget.dataset.label;
            }
            opts.callback && opts.callback({
                type: this.type,
                input,
                id,
                label
            });
        }
        this.handleAutoclose = (event) => {
            if(!self.refs.input.contains(event.target)) {
                if(self.parent && self.parent.cancelAutocomplete) {
                    self.parent.cancelAutocomplete();
                } else {
                    this.unmount();
                }
            }
        }
    </script>
</graphjs-autocomplete>