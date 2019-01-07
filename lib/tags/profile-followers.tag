<graphjs-profile-followers class="graphjs-element graphjs-root graphjs-wallet">
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <p if={empty}>{i18n.noUsersText}</p>
        <!--
        <p if={list.length > 0}>{list.length + ' Follower' + (list.length > 1 ? 's' : '')}</p>
        -->
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
        import getFollowers from '../scripts/getFollowers.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['profile-followers'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;

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
            getFollowers(self.id, function(response) {
                if(response.success) {
                    self.list = Object.keys(response.followers);
                    self.empty = self.list.length == 0 ? true : false;
                    if(self.parent.tags.hasOwnProperty('graphjs-profile-header')) {
                        self.parent.tags['graphjs-profile-header'].profile.follower_count = self.list.length;
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
                action: 'updateProfileFollowers'
            });
        }
    </script>
</graphjs-profile-followers>