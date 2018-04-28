<graphjs-group-card class={'card box' + (loaded ? '' : ' loading')}>
    <div class="information" if={group}>
        <img src={group.cover || 'lib/images/covers/group.png'} />
        <a data-link="group" data-id={id} onclick={handleShow} if={group}>{group.title}</a>
        <p>{group.count == 1 ? group.count + ' Member' : group.count + ' Members'}</p>
    </div>
    <button if={(!group || !joinInformation) && loaded}>&middot; &middot; &middot;</button>
    <button if={(group && joinInformation) && loaded} onclick={joined ? handleLeave : handleJoin}>{joined ? 'Leave Group' : 'Join Group'}</button>
    <div if={!loaded} class="placeholder loader">
        <div class="information">
            <div class="cover rectangle fill"></div>
            <div class="title paragraph centered">
                <div class="line fill"></div>
                <div class="line fill"></div>
            </div>
            <div class="description line centered fill"></div>
            <div class="button rectangle fill"></div>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-card.less';
    </style>
    <script>
        import getGroup from '../scripts/getGroup.js';
        import joinGroup from '../scripts/joinGroup.js';
        import leaveGroup from '../scripts/leaveGroup.js';
        import showGroup from '../scripts/showGroup.js';
        import getUser from '../scripts/getUser.js';
        import listMembers from '../scripts/listMembers.js';

        this.id = opts.id;
        this.members = opts.id;

        this.on('before-mount', function() {
            this.handleInformation();
            this.handleMembers();
        });
        this.on('mount', function() {
            opts.theme && this.root.classList.add(opts.theme);
        });

        this.handleInformation = () => {
            let self = this;
            self.id && getGroup(self.id, function(response) {
                if(response.success) {
                    self.group = response.group;
                    self.loaded = true;
                    self.update();
                } else {
                    self.loaded = true;
                    //Handle errors
                }
            });
        }
        this.handleMembers = () => {
            let self = this;
            self.id && listMembers(self.id, function(response) {
                if(response.success) {
                    self.members = response.members;
                    self.update();
                    getUser(function(response) {
                        if(response.success) {
                            self.joined = self.members.includes(response.id);
                            self.joinInformation = true;
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
        this.handleShow = (event) => {
            event.preventDefault();
            let dataset = event.currentTarget.dataset;
            switch(dataset.link) {
                case 'group':
                    showGroup({
                        id: dataset.id,
                        scroll: true
                    });
                    break;
            }
        }
        this.handleJoin = () => {
            let self = this;
            joinGroup(self.id, function(response) {
                if(response.success) {
                    self.joined = true;
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
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.handleUpdate = () => this.update();
    </script>
</graphjs-group-card>