<graphjs-input-text class="graphjs-element graphjs-root">
    <div
        ref="input"
        class="graphjs-input"
        contenteditable="true"
        data-placeholder={placeholder}
        style={
            (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
            (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
            (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
            (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
        }
    ></div>
    <script>
        import Tribute from 'tributejs';
        import sanitizeHTML from 'sanitize-html';
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import listMembers from '../scripts/listMembers.js';
        import getProfile from '../scripts/getProfile.js';
        import {downsizeImage} from '../scripts/client.js';

        let self = this;

        this.downsizeImage = downsizeImage;
        this.mentionType = opts.mentionType === 'members' ? 'members' : 'users';
        this.placeholder = opts.placeholder || 'Enter text here';
        this.defaultAvatar = opts.defaultAvatar || window.GraphJSConfig.defaultAvatar;

        this.userMention = !(opts.mentionUser === 'disabled');
        this.groupMention = !(opts.mentionGroup === 'disabled');
        this.activeMentionOptions = [];
        this.commonMentionOptions = {
            selectClass: 'graphjs-highlighted',
            noMatchTemplate: null,
            requireLeadingSpace: true,
            replaceTextSuffix: '\n',
            positionMenu: true,
            spaceSelectsMatch: false,
            searchOpts: {
                pre: '<span class="graphjs-match">',
                post: '</span>'
            }
        }
        this.userMentionOptions = {
            ...this.commonMentionOptions,
            trigger: '@',
            selectTemplate: function (item) {
                return '<a class="graphjs-mention">@' + item.original.username + '</a>';
            },
            menuItemTemplate: function (item) {
                let avatar = item.original.avatar ? downsizeImage(item.original.avatar, 40) : self.defaultAvatar;
                return '<a class="graphjs-option"><img src="' + avatar + '" />' + item.string + '</a>';
            },
            lookup: 'username',
            fillAttr: 'username',
            allowSpaces: false,
            values: function(query, execute) {
                self.handleMentionContainer();
                if(self.mentionType === 'users') {
                    if(self.userMentionData) {
                        execute(self.userMentionData);
                    } else {
                        self.userMentionData = [];
                        getMembers(function(response) {
                            if(response.success) {
                                Object.keys(response.members).forEach(id => {
                                    self.userMentionData.push({
                                        id,
                                        username: response.members[id].username,
                                        avatar: response.members[id].avatar
                                    });
                                });
                            } else {
                                //Handle error
                            }
                        });
                        execute(self.userMentionData);
                    }
                } else {
                    if(self.memberMentionData) {
                        execute(self.memberMentionData);
                    } else {
                        self.memberMentionData = [];
                        if(self.mentionSource) {
                            listMembers(self.mentionSource, function(response) {
                                if(response.success) {
                                    Object.keys(response.members).forEach(id => {
                                        self.memberMentionData.push({
                                            id,
                                            username: response.members[id].username,
                                            avatar: response.members[id].avatar
                                        });
                                    });
                                } else {
                                    //Handle error
                                }
                            });
                        }
                        execute(self.memberMentionData);
                    }
                }
            }
        }
        this.groupMentionOptions = {
            ...this.commonMentionOptions,
            trigger: '#',
            selectTemplate: function(item) {
                return '<a class="graphjs-mention">#' + item.original.title.replace(/ /g, '_') + '</a>';
            },
            menuItemTemplate: function(item) {
                return '<a class="graphjs-option">' + item.string + '</a>';
            },
            lookup: 'title',
            fillAttr: 'title',
            allowSpaces: true,
            values: function(query, execute) {
                self.handleMentionContainer();
                if(self.groupMentionData) {
                    execute(self.groupMentionData);
                } else {
                    self.groupMentionData = [];
                    listGroups(function(response) {
                        if(response.success) {
                            response.groups.forEach((group, index) => {
                                let id = group.id;
                                self.groupMentionData.push({
                                    id,
                                    title: group.title
                                });
                            });
                        } else {
                            //Handle error
                        }
                    });
                    execute(self.groupMentionData);
                }
            }
        }

        this.on('mount', function() {
            let input = self.refs.input;
            // Listen to the events
            this.handleEvents();
            // Add paste event listener
            this.refs.input.addEventListener('paste', (event) => this.sanitizeHTML(event));
            // Add mention options
            this.userMention && this.activeMentionOptions.push({
                ...this.userMentionOptions,
                //menuContainer should be set here
            });
            this.groupMention && this.activeMentionOptions.push({
                ...this.groupMentionOptions,
                //menuContainer should be set here
            });
            // Initiate mention function
            this.mention = new Tribute({
                collection: this.activeMentionOptions
            });
            // Attach mention function to text box
            this.mention.attach(input);
        });

        this.value = type => {
            return type === 'html'
                ? this.refs.input.innerHTML
                : this.refs.input.innerText;
        }

        this.clear = () => {
            this.refs.input.innerHTML = '';
        }

        this.focus = () => {
            this.refs.input.focus();
        }

        this.sanitizeHTML = (event) => {
            let copied = event.clipboardData || window.clipboardData;
            let paste = copied.getData('text/html') || copied.getData('text');
            if(copied.types.indexOf('text/html') !== -1) {
                event.preventDefault();
                event.stopPropagation();
                paste = sanitizeHTML(paste, {
                    allowedTags: ['br'],
                    selfClosing: ['br']
                });
            } else if(paste.indexOf('iframe') !== -1) {
                return;
            }
            event.preventDefault();
            event.stopPropagation();
            paste = paste.replace(/&nbsp;/g, ' ');
            let selection = window.getSelection();
            if (!selection.rangeCount) return false;
            let element = document.createElement('span');
            element.textContent = paste;
            let range = selection.getRangeAt(0);
            range.insertNode(element);
            range = range.cloneRange();
            range.selectNodeContents(element);
            range.collapse(false);
            selection.removeAllRanges();
            selection.addRange(range);
            if (opts.eventInput) {
                opts.eventInput();
            }
        }

        this.handleMentionContainer = () => {
            let element = document.querySelector('.tribute-container');
            if(!element.classList.contains('graphjs-mention-container')) {
                element.classList.add('graphjs-mention-container');
                element.classList.add('graphjs-root');
            }
        }

        this.handleEvents = () => {
            Object.keys(opts)
                .filter(key => key.startsWith('event'))
                .reduce((data, prefixedEventName) => {
                    // Get event name
                    let eventName = prefixedEventName.replace('event', '').toLowerCase();
                    // Add event listener
                    self.refs.input.addEventListener(eventName, opts[prefixedEventName]);
                }, {});
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
    </script>
</graphjs-input-text>