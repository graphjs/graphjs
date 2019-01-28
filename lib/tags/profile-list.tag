<graphjs-profile-list class="graphjs-element graphjs-root graphjs-wallet">
    <!-- the only difference from list is the tag itself and this.content = 'users'; -->
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <graphjs-profile-card each={id in list} id={id} target={target}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{language.loginButton}</button>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import language from '../scripts/language.js';
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("profile-list");

        this.language = language('profile-list', opts);                

        this.content = 'users';
        this.list = [];
        this.loaded = true;
        this.placeholderCount = 6;
        this.target = opts.target;

        this.on('before-mount', function() {
            opts.access == 'private'
            ? this.handleUser()
            : this.handleContent();
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
            this.content == 'users'
            ? getMembers(function(response) {
                if(response.success) {
                    self.list = Object.keys(response.members);
                    self.empty = self.list.length == 0 ? true : false;
                    self.update();
                } else {
                    //Handle error
                }
            })
            : listGroups(function(response) {
                if(response.success) {
                    for(let group of response.groups) {
                        self.list.push(group.id);
                        self.empty = self.list.length == 0 ? true : false;
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
                action: 'updateList'
            });
        }
    </script>
</graphjs-profile-list>