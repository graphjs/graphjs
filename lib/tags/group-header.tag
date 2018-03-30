<graphjs-group-header class="box">
    <div class="information" if={group}>
        <div class="cover" style={'background-image: url(' + (group.cover ? 'https://' + group.id + '.png' : 'lib/images/covers/group.png') + ');'}></div>
        <a>{group.title}</a>
        <p>{group.description}</p>
        <button onclick={joined ? handleLeave : handleJoin}>
            {joined ? 'Leave Group' : 'Join Group'}
            <span if={group.count}>{group.count.length}</span>
        </button>
    </div>
    <div class="information" if={!group}>
        <div class="cover" style="background-image: url(lib/images/covers/group.png)"></div>
        <a>Group doesn't exist.</a>
        <p>We couldn't find any group matching this id.</p>
        <button onclick={handleUpdate}>Refresh</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-header.less';
    </style>
    <script>
        import getGroup from '../scripts/getGroup.js';
        import joinGroup from '../scripts/joinGroup.js';
        import leaveGroup from '../scripts/leaveGroup.js';
        import showGroup from '../scripts/showGroup.js';
        import getUser from '../scripts/getUser.js';
        import listMembers from '../scripts/listMembers.js';

        this.id = opts.id;
        this.userId = undefined;

        this.on('before-mount', function() {
            this.handleInformation();
            this.handleMembers();
        });
        this.on('mount', function() {
            opts.theme && this.root.classList.add(opts.theme);
        });

        this.handleInformation = () => {
            let self = this;
            getGroup(self.id, function(response) {
                if(response.success) {
                    self.group = response.group;
                    console.log(self.group.count)
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleMembers = () => {
            let self = this;
            listMembers(self.id, function(response) {
                if(response.success) {
                    self.members = response.members;
                    self.update();
                    getUser(function(response) {
                        if(response.success) {
                            self.joined = self.members.includes(response.id);
                            self.update();
                        } else {
                            //Handle errors
                        }
                    });
                } else {
                    //Handle errors
                }
            });
        };
        this.handleJoin = () => {
            let self = this;
            joinGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = true;
                    self.handleInformation();
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleLeave = () => {
            let self = this;
            leaveGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = false;
                    self.handleInformation();
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleUpdate = () => this.update();
    </script>
</graphjs-group-header>