<graphjs-group-card class={opts.theme ? opts.theme + ' card box' : 'card box'}>
    <div class="information" if={group}>
        <img src={group.cover || 'lib/images/covers/group.png'} />
        <a>{group.title}</a>
        <p>{group.memberCount == 1 ? group.memberCount + ' Member' : group.memberCount + ' Members'}</p>
    </div>
    <div class="information" if={!group}>
        <img src="lib/images/covers/group.png" />
        <a>Group doesn't exist.</a>
        <p>We couldn't find any group matching this id.</p>
    </div>
    <button if={group} onclick={handleJoin}>{joined ? 'Joined' : 'Join Group'}</button>
    <button if={!group} onclick={handleUpdate}>Refresh</button>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-card.less';
    </style>
    <script>
        import listGroups from '../scripts/listGroups.js';
        import listMembers from '../scripts/listMembers.js';

        this.handleInformation = () => {
            let self = this;
            //Change this to getGroup(id) function
            listGroups(function(response) {
                if(response.success) {
                    for(let i = 0; i < response.groups.length; i++) {
                        if(response.groups[i].id == self.id) {
                            self.group = response.groups[i];
                            listMembers(self.id, function(response) {
                                if(response.success) {
                                    self.group['memberCount'] = response.members.length;
                                    self.update();
                                }
                            })
                        }
                    }
                } else {
                    //Handle errors
                }
            });
        }
        this.handleJoin = () => {

        }
        this.handleUpdate = () => this.update();

        this.id = opts.id;
        this.joined = false;
        this.on('mount', function() {
            this.handleInformation();
        });
    </script>
</graphjs-group-card>