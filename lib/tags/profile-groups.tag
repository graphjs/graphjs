<graphjs-profile-groups class="wallet">
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <p if={list.length <= 0}>This user does not have any groups.</p>
        <!--
        <p if={list.length > 0}>{'Member of ' + list.length + ' Group' + (list.length > 1 ? 's' : '')}</p>
        -->
        <graphjs-group-card each={id in list} id={id}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <graphjs-group-card if={list.length == 0}></graphjs-group-card>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to display content</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import listMemberships from '../scripts/listMemberships.js';
        import getUser from '../scripts/getUser.js';

        this.id = opts.id;
        this.list = [];
        this.loaded = true;

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.handleContent = () => {
            let self = this;
            listMemberships(self.id, function(response) {
                if(response.success) {
                    for(let group of response.groups) {
                        self.list.push(group.id)
                    }
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
</graphjs-profile-groups>