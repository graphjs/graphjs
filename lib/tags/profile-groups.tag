<graphjs-profile-groups class="graphjs-element graphjs-root graphjs-wallet">
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <p if={loaded && empty}>{i18n.noGroupsText}</p>
        <graphjs-group-card each={id in list} id={id}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0 && !empty}></graphjs-group-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">{i18n.loginButtonText}</button>
    </div>
    <script>
        import listMemberships from '../scripts/listMemberships.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['profile-groups'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

        this.id = opts.id;
        this.noGroupsText = opts.noGroupsText;
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
            listMemberships(self.id, function(response) {
                if(response.success) {
                    for(let group of response.groups) {
                        self.list.push(group.id);
                    }
                    self.empty = self.list.length == 0 ? true : false;
                    if(self.parent.tags.hasOwnProperty('graphjs-profile-header')) {
                        self.parent.tags['graphjs-profile-header'].profile.membership_count = self.list.length;
                        self.parent.tags['graphjs-profile-header'].update();
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
                action: 'updateProfileGroups'
            });
        }
    </script>
</graphjs-profile-groups>