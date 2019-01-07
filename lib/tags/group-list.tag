<graphjs-group-list class="graphjs-element graphjs-root graphjs-wallet">
    <!-- the only difference from list is the tag itself and this.content = 'groups'; -->
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <graphjs-group-card each={id in list} id={id} target={target}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <script>
        import analytics from '../scripts/analytics.js';
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        analytics("group-list");

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['star-list'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        this.content = 'groups';
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
</graphjs-group-list>