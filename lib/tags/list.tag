<graphjs-list class="graphjs-root graphjs-wallet">
    <div class={'graphjs-content' + (loaded ? '' : ' graphjs-loading') + (blocked ? ' graphjs-blocked' : '')}>
        <graphjs-profile-card if={content == 'users'} each={id in list} id={id}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={content == 'users' && list.length == 0}></graphjs-profile-card>
        <graphjs-group-card if={content == 'groups'} each={id in list} id={id}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={content == 'groups' && list.length == 0}></graphjs-group-card>
        <button if={blocked} onclick={handleBlock} class="graphjs-blockage">Login to display content</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import getMembers from '../scripts/getMembers.js';
        import listGroups from '../scripts/listGroups.js';
        import getSession from '../scripts/getSession.js';
        import showLogin from '../scripts/showLogin.js';

        this.content = opts.content || 'users';
        this.list = [];
        this.loaded = true;
        this.placeholderCount = 6;

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
</graphjs-list>