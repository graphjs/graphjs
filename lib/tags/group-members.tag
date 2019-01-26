<graphjs-group-members class="graphjs-element graphjs-root graphjs-wallet">
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <p if={loaded && empty}>{noMembersText || i18n.noFollowersText}</p>
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <script>
        import listMembers from '../scripts/listMembers.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['forum-list'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        this.id = opts.id;
        this.noMembersText = opts.noMembersText;
        this.list = [];
        this.loaded = true;

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.restart = () => {
            this.loaded = true;
            this.blocked = false;
            this.update();
            this.handleUser();
        }
        this.handleUser = () => {
            let self = this;
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
            let self = this;
            listMembers(self.id, function(response) {
                if(response.success) {
                    self.list = response.members;
                    self.empty = self.list.length == 0 ? true : false;
                    if(self.parent && self.parent.tags.hasOwnProperty('graphjs-group-header')) {
                        self.parent.tags['graphjs-group-header'].group.count = self.list.length;
                        self.parent.tags['graphjs-group-header'].update();
                    }
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleBlock = (event) => {
            event.preventDefault();
            showLogin({
                action: 'updateGroupMembers'
            });
        }
    </script>
</graphjs-group-members>