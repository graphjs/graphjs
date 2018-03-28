<graphjs-group-card class={opts.theme ? opts.theme + ' card box' : 'card box'}>
    <div class="information" if={group}>
        <img src={group.cover || 'lib/images/covers/group.png'} />
        <a>{group.title}</a>
        <p>{group.count == 1 ? group.count + ' Member' : group.count + ' Members'}</p>
    </div>
    <div class="information" if={!group}>
        <img src="lib/images/covers/group.png" />
        <a>Group doesn't exist.</a>
        <p>We couldn't find any group matching this id.</p>
    </div>
    <button if={group} onclick={!joined && handleJoin}>{joined ? 'Joined' : 'Join Group'}</button>
    <button if={!group} onclick={handleUpdate}>Refresh</button>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-card.less';
    </style>
    <script>
        import getGroup from '../scripts/getGroup.js';

        this.id = opts.id;
        this.joined = false;
        
        this.on('before-mount', function() {
            this.handleInformation();
        });

        this.handleInformation = () => {
            let self = this;
            getGroup(self.id, function(response) {
                if(response.success) {
                    self.group = response.group;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleJoin = () => {
            joinGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = true;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleUpdate = () => this.update();
    </script>
</graphjs-group-card>