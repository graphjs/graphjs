<graphjs-group-members class={'graphjs-element graphjs-root graphjs-wallet' + (loaded && (empty ? ' graphjs-box' : ''))}>
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <p if={loaded && empty}>{language.noMembers}</p>
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0 && !empty}></graphjs-profile-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{language.loginButton}</button>
    </div>
    <script>
        import language from '../scripts/language.js';
        import listMembers from '../scripts/listMembers.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        this.language = language('group-members', opts);
        
        this.id = opts.id;
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
                if(response.success && !response.pending) {
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