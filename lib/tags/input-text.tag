<graphjs-input-text class="graphjs-element graphjs-root">
    <div
        id={'graphjs-input-' + identifier}
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
    <div ref="mentionContainer" class="graphjs-mention-container" id={'graphjs-container-' + identifier}></div>
    <script>
        import Tribute from 'tributejs';
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import listMembers from '../scripts/listMembers.js';
        import getProfile from '../scripts/getProfile.js';
        import {downsizeImage} from '../scripts/client.js';


        let self = this;

        this.downsizeImage = downsizeImage;
        this.identifier = Math.floor(Math.random() * 1000000);
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
            positionMenu: false,
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
                return '<a class="graphjs-mention">#' + item.original.title + '</a>';
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
            let input = document.getElementById('graphjs-input-' + self.identifier);
            let container = document.getElementById('graphjs-container-' + self.identifier);
            // Add mention options
            self.userMention && self.activeMentionOptions.push({
                ...self.userMentionOptions,
                menuContainer: container
            });
            self.groupMention && self.activeMentionOptions.push({
                ...self.groupMentionOptions,
                menuContainer: container
            });
            // Initiate mention function
            self.mention = new Tribute({
                collection: self.activeMentionOptions
            });
            // Attach mention function to text box
            self.mention.attach(input);
        });

        this.handleMentionContainer = () => {
            let element = document.querySelector('.tribute-container');
            if(!self.refs.mentionContainer.contains(element)) {
                element.classList.add('graphjs-options');
                self.refs.mentionContainer.appendChild(element);
            }
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