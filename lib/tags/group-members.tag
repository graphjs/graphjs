<graphjs-group-members class="wallet">
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to display content</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import listMembers from '../scripts/listMembers.js';
        import getUser from '../scripts/getUser.js';

        this.id = opts.id;
        this.list = [];
        this.loaded = true;

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.handleContent = () => {
            let self = this;
            listMembers(self.id, function(response) {
                if(response.success) {
                    self.list = response.members;
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleUser = () => {
            let self = this;
            getUser(function(response) {
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
    </script>
</graphjs-group-members>